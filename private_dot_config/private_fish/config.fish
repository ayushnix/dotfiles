# config.fish

# set the umask
# this is needed when .bash_profile doesn't act as the display manager
umask 0027

#: ALIAS {{{

function vi -d 'use busybox vi'
  busybox vi $argv
end

# busybox cat performs a bit better than gnu cat when using fish+tmux
function cat -d 'use busybox cat'
  busybox cat $argv
end

# busybox tar gets alignment of columns right when using tvf
function tar -d 'use busybox tar'
  busybox tar $argv
end

# use gnu tar if needed
function gtar -d 'use gnu tar'
  command tar $argv
end

function ip -w ip -d 'use ip with colors'
  command ip -c $argv
end

function ipb -w ip -d 'show brief output of ip addr'
  ip -c -br -4 a $argv
end

function vim -w nvim -d 'use neovim instead of vim'
  env SHELL=/bin/sh nvim $argv
end

function df -d 'show human readable numbers'
  command df -hT $argv
end

function clip -w wl-copy -d 'copy data to clipboard'
  wl-copy $argv
end

function less -w less -d 'preserve colors of stdin'
  command less -R $argv
end

function ll -w exa -d 'list files and directors'
  exa -lag --group-directories-first $argv
end

function chmox -d "make a file executable"
  chmod +x $argv
end

function dice -w xkcdpass -d 'use diceware to generate 6 word passphrases'
  xkcdpass -c 10 $argv
end

#: }}}

#: FUNCTIONS {{{

function confirm -d 'confirm before execution'
  while true
    read -p 'echo "Confirm (Y/n):"' -l conf
    switch $conf
      case Y
        $argv
        return 0
      case n
        return 1
    end
  end
end

function man -w man -d 'colorized man pages'
  # bold
  set -x LESS_TERMCAP_md (set_color --bold red)
  set -x LESS_TERMCAP_me (set_color normal)
  # underline
  set -x LESS_TERMCAP_us (set_color --underline green)
  set -x LESS_TERMCAP_ue (set_color normal)

  command man $argv
end

#: }}}

#: PACMAN {{{

function pupg -d 'upgrade packages'
  printf "%s\n" "--------------------------"
  printf "%s\n" "starting pacman update ..."
  printf "%s\n" "--------------------------"
  doas pacman -Syu $argv

  if command -q aur
    printf "%s\n" "------------------------"
    printf "%s\n" "checking aur updates ..."
    printf "%s\n" "------------------------"
    aur repo -l | aur vercmp
  end
end

function pins -w pacman -d '(re)install a package'
  doas pacman -S $argv
end

function prem -w pacman -d 'remove a package'
  doas pacman -Rns $argv
end

function psea -d 'search for a package using pacman or aur (-a/--aur)'
  argparse 'a/aur' -- $argv
  or return

  if set -q _flag_aur
    aur search -k NumVotes $argv
    return 0
  else
    pacman -Ss $argv
  end
end

function pinf -w pacman -d 'view information of a package'
  pacman -Qi $argv 2> /dev/null; or pacman -Si $argv
end

function filepkg -w pacman -d 'check which package a binary belongs to'
  pacman -Qo $argv
end

function mkpg -w aur -d 'build and install an AUR package'
  aur build -s --clean $argv
end

function pacpre -d 'use fzf to preview information of pacman packages'
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
end

#: }}}

#: SYSTEMD {{{

function pw -d 'power off the machine'
  confirm doas /usr/sbin/systemctl poweroff
end

function sl -d 'suspend the machine'
  confirm doas /usr/sbin/systemctl suspend
end

function re -d 'reboot the machine'
  confirm doas /usr/sbin/systemctl reboot
end

function errlogs -d 'show the errors in logs since boot'
  printf "%s\n" "-----------"
  printf "%s\n" "[#] JOURNAL"
  printf "%s\n" "-----------"
  journalctl -b -p 0..3 $argv
  printf "%s\n" "------------------------"
  printf "%s\n" "[#] SYSTEMD FAILED UNITS"
  printf "%s\n" "------------------------"
  set -l sys_srv (systemctl --failed | jc --systemctl | jq -r '.[].unit')
  if [ "$sys_srv[1]" != 0 ]
    printf "%s\n" "$sys_srv"
  else
    printf "%s\n" "NONE"
  end
  printf "%s\n" "-----------------------------"
  printf "%s\n" "[#] SYSTEMD USER FAILED UNITS"
  printf "%s\n" "-----------------------------"
  set -l usr_srv (systemctl --user --failed | jc --systemctl | jq -r '.[].unit')
  if [ "$usr_srv[1]" != 0 ]
    printf "%s\n\n" "$usr_srv"
  else
    printf "%s\n\n" "NONE"
  end
end

#: }}}

#: ABBREVIATIONS {{{

if status --is-interactive
  # GIT
  abbr -a -g -- gits 'git status'
  abbr -a -g -- gita 'git add'
  abbr -a -g -- gitd 'git diff'
  abbr -a -g -- gitl 'git log --decorate --graph --all --oneline'
  abbr -a -g -- gitcm 'git commit'
  abbr -a -g -- gitpl 'git pull'
  abbr -a -g -- gitps 'git push'
  abbr -a -g -- gitrb 'git rebase'
  abbr -a -g -- gitsw 'git switch'
  abbr -a -g -- gitsh 'git show'
  abbr -a -g -- gitcl 'git clone'
  # DOAS
  abbr -a -g -- doasedit 'doas busybox vi'
  abbr -a -g -- doascat 'doas busybox cat'
end

#: }}}

# some terminals don't consider ctrl+enter to be the same as enter
bind \c\[27\;5\;13~ 'execute'
bind \e\[27\;5\;13~ 'execute'

zoxide init fish | source

# vim:foldmethod=marker
