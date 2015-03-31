alias mysql='/usr/local/mysql/bin/mysql'
export PATH="/usr/local/opt/ruby/bin:$PATH:/Users/ayon.ghosh/dev/arcanist/arcanist/bin:/usr/local/mysql/bin/:/Users/ayon.ghosh/chromium/depot_tools/depot_tools:/Users/ayon.ghosh/dev/phpmd/phpmd/src/bin"

function parse_git_branch () {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOUR="\[\033[0m\]"

PS1="$GREEN\u@machine$NO_COLOUR:\w$YELLOW\$(parse_git_branch)$NO_COLOUR\$ "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
