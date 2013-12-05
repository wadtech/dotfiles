export PATH=/usr/local/bin:/usr/local/share/npm/bin:/usr/local/php5/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

#Add z completion
. ~/.z.sh

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad
alias l="ls -lh"
alias servedir="php -S localhost:3000"

# Brew's bash completion
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
#fi
grey=`tput setaf 7`
cyan=`tput setaf 6`
red=`tput setaf 1`
green=`tput setaf 2`
sgr0=`tput sgr0`
magenta=$(tput setaf 5)
yellow=$(tput setaf 3)

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

export PS1='\[${grey}\]BJR-MBP:.\[$(branch_color)\]$(parse_git_branch)\[${magenta}\]@\[${yellow}\]\w\[${sgr0}\]: '


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
