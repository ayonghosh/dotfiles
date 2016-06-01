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

# Git - show only changed files for a particular commit ID (if provided) or the latest commit
function gitch() {
  if [[ $# -eq 0 ]] ; then
    COMMITID=$(git log --format="%H" -n 1)
  else
    COMMITID="$1"
  fi
  git diff-tree --no-commit-id --name-only -r ${COMMITID}
}
alias gitch='gitch'

# Rietveld Code review tool
alias cr='path/to/upload.py'

function code_review() {
  CHANGED_FILES_LIST=" "
  while read -r FILE; do
    CHANGED_FILES_LIST="${CHANGED_FILES_LIST} ${FILE}"
  done  < <(gitch)
#  cr --rev=master --oauth2 --no_oauth2_webbrowser $CHANGED_FILES_LIST
  cr --rev=master $CHANGED_FILES_LIST
}
alias crev='(cd /path/to/repo && code_review)'

function code_review_update() {
  CHANGED_FILES_LIST=" "
  while read -r FILE; do
    CHANGED_FILES_LIST="${CHANGED_FILES_LIST} ${FILE}"
  done  < <(gitch)
#  cr --rev=master $CHANGED_FILES_LIST -i $1 --oauth2 --no_oauth2_webbrowser
  cr --rev=master $CHANGED_FILES_LIST -i $1
}
alias crevu='code_review_update $1'

# Log Bash history
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'
