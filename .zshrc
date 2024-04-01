# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

HIST_STAMPS="dd.mm.yyyy"

plugins=(
    zsh-syntax-highlighting
    git
    # adb
    colorize
    zsh-autosuggestions
    sudo
    copybuffer
    # docker
    fzf
    npm node
    colored-man-pages
    pip
)

source $ZSH/oh-my-zsh.sh

# User configuration

# PATH
export PATH=$PATH:~/.local/scripts:/home/mikhail/.local/share/gem/ruby/3.0.0/bin:/home/mikhail/.local/scripts/record:/home/mikhail/.local/scripts/sb:/home/mikhail/.cargo/bin:/home/mikhail/yandex-cloud/bin:/home/mikhail/.local/bin/spotify/usr/bin:/home/mikhail/go/bin:/home/mikhail/.local/scripts/dmenu:/home/mikhail/.local/scripts:/home/mikhail/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/mikhail/.dotnet/tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/scripts

export LANG=en_US.UTF-8
export EDITOR=/usr/local/bin/nvim
export BROWSER=/usr/bin/firefox
export PARGER=/usr/bin/bat
export READER=/usr/bin/zathura
export MANPATH=/usr/bin/man:/usr/local/man:/usr/share/man
export TERM=st
export TERMINAL=st

export IMAGE_VIEWER=/usr/bin/feh
export FILE_MANAGER=~/.local/bin/lfub
export AUDIO_PLAYER=/usr/bin/mpv
export VIDEO_PLAYER=/usr/bin/mpv

# export OPENER=run-mailcap
export XDG_CONFIG_HOME=~/.config

source ~/.zshenv

# High DPI
# https://wiki.archlinux.org/title/HiDPI#Qt_5
# QT_FONT_DPI=150
# export QT_AUTO_SCREEN_SCALE_FACTOR=1.25
# export QT_ENABLE_HIGHDPI_SCALING=1.25

# ALISES
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g v='nvim'
alias -g vs='nvim -S Session.vim'
alias -g copy='xclip -selection clipboard'
alias -g pwdc='pwd | xclip -selection clipboard'
alias -g g='git'
alias -g lg='lazygit'
alias -g p='python'
alias -g S='sudo pacman -S'
alias -g P='sudo pacman'
alias -g Ss='pacman -Ss'
alias -g Si='pacman -Si'
alias -g Qi='pacman -Qi'
alias -g z='zathura'
alias -g tree='tree -C'
alias -g grep='grep --color=auto'
alias -g ls='exa --icons'
alias -g l='exa -1 --icons'
alias -g ll='exa -lh --icons'
alias -g la='exa -lha --icons'
alias -g myip='wget -qO- eth0.me $argv'

# rmtrash
alias rm='rmtrash'
alias rmdir='rmdirtrash'

alias sudo='sudo '
alias se='sudoedit '
alias cal='cal -m3'

alias clips='rlwrap clips'

alias dfh='df -h | grep "^/dev/"'

lfcd () { # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lfub -print-last-dir "$@")"
}

alias lf='lfcd'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /home/mikhail/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /home/mikhail/.config/broot/launcher/bash/br
