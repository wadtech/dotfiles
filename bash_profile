alias weberr='tail -f /var/log/apache2/error_log'
alias dblog='tail -f /usr/local/var/mysql/Peters-iMac.log'

export PATH='/usr/local/bin:/usr/local/php5/bin:/usr/local/sbin:/Users/peter/bin:/usr/local/share/npm/bin:/usr/local/share/npm/bin:/usr/local/share/npm/bin:/usr/local/share/npm/bin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
    return 0
  fi
  echo -e "(${gitver}) "
}

branch_color ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git diff --quiet 2>/dev/null >&2
    then
      color="${c_green}"
    else
      color=${c_red}
    fi
  else
    return 0
  fi
  echo -ne $color
}

PS1='\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]\u@\[${c_red}\]\w\[${c_sgr0}\]: '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
