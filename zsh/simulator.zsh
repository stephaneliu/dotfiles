# Bring up the React Native dev simulator pointing at a local Rails server.
#
# Usage:
#   simulator <port>                # quick mode (default)
#   simulator -q|--quick <port>     # skip update-graphql-schema + update-data-contracts
#   simulator -f|--full  <port>     # full pipeline (yarn start:local)
#   simulator                       # prompt for port
#
# Patches the three hardcoded `:3000` references in the mobile repo so dev
# clients and schema fetches both target the requested Rails port:
#   - scripts/environment/init-env.js   formatLocal `http://${_ip}:<port>`   (rewrites .env each run)
#   - .env                              LOCAL_API_BASE_URL=http://#:<port>   (in case init-env didn't run)
#   - scripts/update-graphql-schema.ts  LOCAL_GRAPHQL_API_URL=http://lvhost.me:<port>/graphql
#
# Kills any existing Metro on :8081 so the new env values actually take effect.
# Override the mobile repo path with SIMULATOR_MOBILE_DIR if it lives elsewhere.
function simulator() {
  local mode="quick"
  local port=""
  local mobile_dir="${SIMULATOR_MOBILE_DIR:-$HOME/code/companycam/companycam-mobile}"

  while (( $# )); do
    case "$1" in
      -q|--quick) mode="quick"; shift ;;
      -f|--full)  mode="full";  shift ;;
      -h|--help)
        cat <<EOF
Usage: simulator [-q|--quick|-f|--full] <port>

  -q, --quick   Skip update-graphql-schema/data-contracts (default).
  -f, --full    Run the standard yarn start:local pipeline.
  -h, --help    Show this help.

Examples:
  simulator 33000          # quick start against local Rails on :33000
  simulator --full 33000   # full start (refresh schema + contracts first)
  simulator                # prompt for port
EOF
        return 0 ;;
      *)
        if [[ -z "$port" && "$1" =~ ^[0-9]+$ ]]; then
          port="$1"
        else
          echo "simulator: unexpected argument: $1" >&2
          return 1
        fi
        shift ;;
    esac
  done

  if [[ -z "$port" ]]; then
    read "port?Rails server port: "
  fi

  if [[ ! "$port" =~ ^[0-9]+$ ]]; then
    echo "simulator: port must be numeric (got '$port')" >&2
    return 1
  fi

  if [[ ! -d "$mobile_dir" ]]; then
    echo "simulator: mobile repo not found at $mobile_dir" >&2
    echo "  set SIMULATOR_MOBILE_DIR to override" >&2
    return 1
  fi

  local ip
  ip=$(ipconfig getifaddr en0)
  if [[ -z "$ip" ]]; then
    echo "simulator: could not detect LAN IP on en0" >&2
    return 1
  fi

  echo "[simulator] mode=$mode port=$port ip=$ip dir=$mobile_dir"

  local env_file="$mobile_dir/.env"
  local init_env_file="$mobile_dir/scripts/environment/init-env.js"
  local schema_file="$mobile_dir/scripts/update-graphql-schema.ts"

  # init-env.js is the actual source of truth — set-env-dev calls it and it
  # rewrites .env from a hardcoded template every run, so patching .env alone
  # is futile.
  if [[ -f "$init_env_file" ]]; then
    sed -i '' -E "s|(formatLocal = \(_ip\) => \`http://\\\$\{_ip\}:)[0-9]+|\1${port}|" "$init_env_file"
  fi

  if [[ -f "$env_file" ]]; then
    sed -i '' -E "s|^(LOCAL_API_BASE_URL=http://#:)[0-9]+|\1${port}|" "$env_file"
  fi

  if [[ -f "$schema_file" ]]; then
    sed -i '' -E "s|(http://lvhost\.me:)[0-9]+(/graphql)|\1${port}\2|" "$schema_file"
  fi

  # Kill any leftover Metro on :8081 so the new dotenv.json actually loads.
  local metro_pids
  metro_pids=$(lsof -ti:8081 2>/dev/null)
  if [[ -n "$metro_pids" ]]; then
    echo "[simulator] killing existing Metro on :8081 (pids: $(echo $metro_pids | tr '\n' ' '))"
    echo "$metro_pids" | xargs kill -9 2>/dev/null
    sleep 1
  fi

  # Boot the iOS Simulator app so it's ready when Metro starts. Non-blocking;
  # no-op if it's already open.
  echo "[simulator] launching Simulator.app"
  open -a Simulator

  (
    cd "$mobile_dir" || exit 1
    export IP_ADDRESS="$ip"

    if [[ "$mode" == "full" ]]; then
      yarn start:local
    else
      node ./scripts/environment/set-env-dev.js local "$ip" \
        && npx expo start --dev-client
    fi
  )
}
