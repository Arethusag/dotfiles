# plugins must be sourced first before oh-my-zsh
plugins=(
git
z
zsh-vi-mode
zsh-autosuggestions
zsh-autocomplete
zsh-syntax-highlighting
fast-syntax-highlighting
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# history search with arrow keys
# this overrides the issue with zsh-vi-mode binding these keys
zvm_bindkey vicmd "${terminfo[kcuu1]}" up-line-or-history
zvm_bindkey viins "${terminfo[kcuu1]}" up-line-or-history
zvm_bindkey vicmd "${terminfo[kcud1]}" down-line-or-history
zvm_bindkey viins "${terminfo[kcud1]}" down-line-or-history

# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/mmarcoux/.local/share/flatpak/exports/share:/usr/share:/usr/local/share
export XDG_CONFIG_DIRS="/etc/xdg"export

# export XDG_SESSION_TYPE="wayland"
# export WAYLAND_DISPLAY="wayland-1"
export BROWSER="firefox"

#set default opener
export OPENER="xdg-open"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set default editor
export EDITOR='nvim'
alias vi='nvim'

#history settings
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
export HISTSIZE="100000"

#custom lf command that switches current directory upon exit
lf() {
    export LF_CD_FILE=/var/tmp/.lfcd-$$
    command lf $@
    if [ -s "$LF_CD_FILE" ]; then
        local DIR="$(realpath "$(cat "$LF_CD_FILE")")"
        if [ "$DIR" != "$PWD" ]; then
            echo "cd to $DIR"
            cd "$DIR"
        fi
        rm "$LF_CD_FILE"
    fi
    unset LF_CD_FILE
}

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Custom FZF commands
exclude_dirs=(
    ./.mozilla 
    ./.cache
    ./.local/share/Trash
    ./.local/share/Steam
    ./.local/share/SteamLibrary
    ./.var
    ./.local/share/flatpak
    ./.local/share/containers
    ./R
)

# for opening files in nvim
vf() {
    local file
    local exclude_part=()
    
    # construct exclusion list
    for dir in "${exclude_dirs[@]}"; do
        exclude_part+=("-path" "$dir" "-prune" "-o")
    done

    # find files and open in nvim
    file=$(find . "${exclude_part[@]}" -type f \( -name ".*" -o -name "*" \) -print \
        | fzf --height 40% --reverse --border) \
        && nvim "$file"
}

# for cd'ing into directories
cf() {
    local dir
    local exclude_part=()

    # construct exclusion list
    for dir in "${exclude_dirs[@]}"; do
        exclude_part+=("-path" "$dir" "-prune" "-o")
    done

     # find directories and cd into them
    dir=$(find . "${exclude_part[@]}" -type d \( -name ".*" -o -name "*" \) -print \
        | fzf --height 40% --reverse --border) \
        && cd "$dir"
}

