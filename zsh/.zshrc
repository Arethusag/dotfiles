# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/mmarcoux/.local/share/flatpak/exports/share:/usr/share:/usr/local/share
export XDG_CONFIG_DIRS="/etc/xdg"export
export XDG_SESSION_TYPE="wayland"
export WAYLAND_DISPLAY="wayland-0"



# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set default editor
export EDITOR='nvim'

# Set name of the theme to load 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

#custom plugins 
plugins=(
git
zsh-vi-mode
zsh-autosuggestions
zsh-autocomplete
zsh-syntax-highlighting
fast-syntax-highlighting
)


# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source $ZSH/oh-my-zsh.sh

# # luaver configuration
# export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"
#
# if [[ ! -d "${LUVER_DIR}/self" ]]; then
#   git clone --quiet https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
# fi
#
# source "${LUVER_DIR}/self/luver.plugin.zsh"

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
vfzf() {
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
cfzf() {
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



#eval "$(direnv hook bash)"


