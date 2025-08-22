if status is-interactive
end

set -gx _ZO_ECHO 1       # Print directory after jumping (like `cd`)
set -gx _ZO_EXCLUDE_DIRS "$HOME/private/*"  # Exclude dirs from history
# functions --erase cd  # Restores Fish’s original `cd`

set -gx BROWSER "brave"
set -gx TERM "alacritty"
set -gx EDITOR "zeditor"
if set -q TMUX
  set -gx TERM "tmux-256color"  # Inside tmux
else
  set -gx TERM "xterm-256color" # Outside tmux
end
set -gx COLORTERM "truecolor"
set -gx LS_COLORS "di 1;3;34:fi=0"

set -g fish_key_bindings fish_default_key_bindings

bind \en down-or-search
bind \ep up-or-search

#  =========================================
#           BASIC ALIASES (using eza)
#  =========================================
alias ls 'eza -a --icons'
alias l 'eza -a --icons'
alias la 'eza -a --icons -l'
alias ll 'eza -a --icons -l'
alias lx 'eza -a --icons -l --sort=extension'
alias lk 'eza -a --icons -l --sort=size'
alias lc 'eza -a --icons -l --sort=changed'
alias lu 'eza -a --icons -l --sort=accessed'
alias lr 'eza -a --icons -l -R'
alias lt 'eza -a --icons -l --sort=modified'
alias lm 'eza -a --icons -l | less'
alias lw 'eza -a --icons -x'
alias labc 'eza -a --icons --sort=name'
alias tree 'eza -a --icons --tree'
alias c 'clear'

# Navigation shortcuts
alias home 'cd ~'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias bd 'cd "$OLDPWD"'

#  =========================================
#           EDITOR ALIASES
#  =========================================
alias n 'nvim'
alias sn 'sudo nvim'
alias v 'vim'
alias sv 'sudo vim'

#  =========================================
#           TMUX ALIASES
#  =========================================
alias tns 'tmux new -s'
alias ta 'tmux attach'
alias td 'tmux detach'

#  =========================================
#           SYSTEM ALIASES
#  =========================================
alias ps 'ps auxf'
alias ping 'ping -c 5'
alias less 'less -R'
alias h "history | grep "
alias p "ps aux | grep "
alias topcpu "ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias find "fzf --preview='bat {}' --bind 'enter:execute(nvim {})'"
alias f "find . | grep "
alias openports 'netstat -tulanp'

# System control
alias reboot 'systemctl reboot'
alias shutdown 'shutdown now'
alias logout 'loginctl kill-session $XDG_SESSION_ID'
alias restart-dm 'systemctl restart display-manager'

#  =========================================
#           PACKAGE MANAGEMENT
#  =========================================
alias rebel 'bash ~/snix/scripts/rebuild'
alias uprebel 'bash ~/snix/scripts/up-rebuild'
alias cwifi 'bash ~/snix/scripts/cwifi'
alias op-net='bash ~/snix/scripts/optimize-network'
alias wb '~/snix/scripts/wset'
alias wq '~/sqtile/scripts/wset'
alias wh '~/shypr/scripts/wset'

#  =========================================
#           FILE OPERATIONS
#  =========================================
alias cp 'cp -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'
alias rmd '/bin/rm  --recursive --force --verbose'

# Disk and space management
alias diskspace "du -S | sort -n -r | less"
alias folders 'du -h --max-depth=1'
alias mountedinfo 'df -hT'
alias duf 'duf -hide special'

#  =========================================
#           PERMISSIONS & SECURITY
#  =========================================
alias mx 'chmod a+x'
alias 000 'chmod -R 000'
alias 644 'chmod -R 644'
alias 666 'chmod -R 666'
alias 755 'chmod -R 755'
alias 777 'chmod -R 777'
alias sha1 'openssl sha1'
alias chown 'sudo chown -R $USER'

#  =========================================
#           DEVELOPMENT & TOOLS
#  =========================================
alias grep 'grep --color=auto'
alias rg 'rg --color=auto'
alias bright 'brightnessctl set'

#  =========================================
#              GIT ALIASES
#  =========================================
alias ga 'git add .'
alias gc 'git commit -m'
alias gp 'git push'
alias git-clean 'git reflog expire --expire=now --all; git gc --prune=now --aggressive'

#  =========================================
#           UTILITY ALIASES
#  =========================================
alias kssh "kitty +kitten ssh"
alias web 'cd /var/www/html'
alias da 'date "+%Y-%m-%d %A %T %Z"'
alias random-lock 'betterlockscreen -u ~/Wallpapers/Pictures --fx blur -l'
alias anime '~/stecore/scripts/./ani-cli'

alias mirror-rating 'rate-mirrors --entry-country=IN --protocol=https arch | sudo tee /etc/pacman.d/mirrorlist'

if command -q starship
  starship init fish | source
end

if command -q zoxide
    set -gx _ZO_FZF_PREVIEW 'ls --color=always {}'
    zoxide init fish | source
end

if command -q fzf
    fzf_key_bindings | source
end

function fzf_nvim --description "Fuzzy-find a file and open in Neovim"
    set -l selected_file (fzf --height=40% --reverse --ansi \
        --prompt="📝 Open in nvim: " \
        --preview 'eza --icons --color=always --long --git --group --modified {1..1} 2>/dev/null' \
        --preview-window=right:60%:wrap)
    if test -n "$selected_file"
        nvim "$selected_file"
        commandline -f repaint
    end
end
bind \er fzf_nvim


function fzf_zoxide_dir --description "Fuzzy-find a directory from zoxide and jump"
    set -l selected_dir (
        zoxide query -l | fzf --height=40% --reverse --ansi \
            --prompt="📂 Jump to: " \
            --preview 'eza --icons --tree --level=2 --color=always {} 2>/dev/null' \
            --preview-window=right:50%:wrap
    )
    if test -n "$selected_dir"
        z "$selected_dir"
        commandline -f repaint
    end
end
bind \ed fzf_zoxide_dir

function gacp
  git add .;git commit -m 's';git push
end

function gac
  git add .;git commit -m
end

function gs
    git status
end

function optimise-nix
  nix-env -q | xargs nix-env -e
  sudo nix-store --gc --print-roots | grep obsolete
end

function clean-nix
  sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +5
  sudo nix-store --gc --print-roots | grep /tmp | awk '{print $1}' | xargs rm -f
end

function store-size
  df -h /              
  du -sh /nix/store     
end

function fish_greeting
  random choice "Hello!" "Hi!" "Good Day!" "Howdy!"
end

function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

function tty_kill_all
    set ttys (who | grep -v 'tty1' | cut -d' ' -f2 | sort -u)
    if test -n "$ttys"
        set tty_csv (string join , $ttys)
        sudo pkill -t "$tty_csv"
    else
        echo "No TTYs found (excluding tty1)"
    end
end
