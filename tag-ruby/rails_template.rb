envrc = <<-EOL
  RED='\033[0;31m'
  NC='\033[0m'
  WHITE='\033[1;37m'
  CYAN='\033[0;36m'

  export ENABLE_LIVE_RELOAD=true
  export PROJECT_RUBY_VERSION=`cat ./.ruby-version`

  printf "${WHITE}Setting ${PURPLE}APP_CODE${NC} to ${BLUE}$APP_CODE${NC}\n"
  source /usr/local/share/chruby/chruby.sh && chruby $PROJECT_RUBY_VERSION
  if [ $? != 0 ]; then
    printf "${WHITE}######## ${RED}Houston, we've got a problem...$PROJECT_RUBY_VERSION UNKNOWN ${WHITE}########${NC}\n"
  else
    printf "${WHITE}Ruby changed to ${CYAN}$PROJECT_RUBY_VERSION${NC}\n"
  fi

  PATH_add bin
EOL

create_file ".envrc", envrc
