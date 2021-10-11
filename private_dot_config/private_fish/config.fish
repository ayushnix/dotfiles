# config.fish

#: BASIC ALIASES {{{
function ip -d 'use ip with colors'
    command ip -c $argv
end

function ipb -d 'show brief output of ip addr'
    command ip -c -br -4 a
end

function rm -d 'disable rm because it is dangerous'
    echo "avoid using rm — use trash and shred instead or use /bin/rm"
    trash $argv
end

function vim -d 'use neovim instead of vim'
    nvim $argv
end

function df -d 'show human readable numbers when using df'
    command df -h $argv
end

function clip -d 'copy data to clipboard'
    wl-copy $argv
end

function less -d 'preserve colors of stdin'
    command less -R $argv
end

function ll -d 'list files and directors'
    exa -lag --group-directories-first $argv
end

function cat -d 'show the output of files and work as a pager'
    command bat $argv
end
#: }}}

#: OTHER USER DEFINED ALIASES AND FUNCTIONS {{{
function ytdwl -d 'embed metadata in youtube-dl videos'
    youtube-dl --add-metadata --embed-subs --all-subs --ignore-errors $argv
end

function ytdwl-aria -d 'embed metadata in youtube-dl videos and download using aria2'
   youtube-dl --add-metadata --embed-subs --all-subs --external-downloader=aria2c \
   --external-downloader-args="--conf-path=$XDG_CONFIG_HOME/aria2/aria2.conf" $argv
end

function dice -d 'use diceware to generate 6 word passphrases'
    xkcdpass -c 10
end

function confirm -d 'confirm before execution'
    while true
        read -p 'echo "Confirm (Yy/Nn):"' -l conf
        switch $conf
          case Y y
            $argv
            return 0
          case N n
            return 1
        end
    end
end

# delete fish history containing use of password-store
function delete-pass -e fish_postexec
    set -l found_items
    builtin history search --prefix --null -- "pass " | while read -lz x
        set found_items $found_items $x
    end
    for i in $found_items
        builtin history delete --exact --case-sensitive -- $i
    end
end
#: }}}

#: PACMAN ALIASES AND FUNCTIONS {{{
function pupg -d 'upgrade packages'
    printf '%s\n' '--------------------------'
    printf '%s\n' 'starting pacman update ...'
    printf '%s\n' '--------------------------'
    doas pacman -Syu $argv

    if command -q aur
      printf '%s\n' '------------------------'
      printf '%s\n' 'checking aur updates ...'
      printf '%s\n' '------------------------'
      aur repo -l | aur vercmp
    end
end

function pins -d '(re)install a package'
    doas pacman -S $argv
end

function prem -d 'remove a package'
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

function pinf -d 'view information of a package'
    pacman -Qi $argv 2> /dev/null; or pacman -Si $argv
end

function filepkg -d 'check which package a binary belongs to'
    pacman -Qo $argv
end

function mkpg -d 'build and install an AUR package'
    aur build -s --clean $argv
end

function pacpre -d 'use fzf to preview information of pacman packages'
    pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
end
#: }}}

#: SYSTEMD ALIASES {{{
function pw -d 'power off the machine'
    confirm systemctl poweroff
end

function sl -d 'suspend the machine'
    confirm systemctl suspend
end

function re -d 'reboot the machine'
    confirm systemctl reboot
end

function errlogs -d 'show the errors in logs since boot'
   journalctl -b -p 0..3 $argv
   systemctl --failed
end
#: }}}

starship init fish | source

# vim:fileencoding=utf-8:foldmethod=marker
