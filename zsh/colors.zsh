# ANSI Colors
# export BLACK='\033[0;30m' # doesn't work well with solarize
# USAGE: printf "I ${LTRED}heart ${RED}Ruby\n"
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export BROWN='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LTGRAY='\033[0;37m'
# export DKGRAY='\033[1;30m' # doesn't work well with solarize
export LTRED='\033[1;31m'
# export LTGREEN='\033[1;32m' # doesn't work well with solarize
# export YELLOW='\033[1;33m' # doesn't work well with solarize
# export LTBLUE='\033[1;34m' # doesn't work well with solarize
export LTPURPLE='\033[1;35m'
# export LTCYAN='\033[1;36m' # doesn't work well with solarize
export WHITE='\033[1;37m'
export NC='\033[0m'

# Force 256 color support see:
# http://www.enigmacurry.com/2009/01/20/256-colors-on-the-linux-terminal/
export TERM=screen-256color

# add color to directories
eval `dircolors ~/.dir_colors`
