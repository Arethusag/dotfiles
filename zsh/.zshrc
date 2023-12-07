# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/mmarcoux/.local/share/flatpak/exports/share

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set default editor
export EDITOR='nvim'

# Set name of the theme to load 
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)
#custom plugins 
plugins+=(zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# luaver configuration
export LUVER_DIR="${LUVER_DIR:-"${XDG_DATA_HOME:-"${HOME}/.local/share"}/luver"}"

if [[ ! -d "${LUVER_DIR}/self" ]]; then
  git clone --quiet https://github.com/MunifTanjim/luver.git "${LUVER_DIR}/self"
fi

source "${LUVER_DIR}/self/luver.plugin.zsh"


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



eval "$(direnv hook bash)"


