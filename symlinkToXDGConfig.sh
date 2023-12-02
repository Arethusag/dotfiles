
#!/bin/zsh

# Source directory containing the folders to link
SOURCE_DIR=$(pwd)

# Destination directory where links will be created
DEST_DIR="$HOME/.config_symlink_test"

# Check if DEST_DIR exists, create if it doesn't
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

# Loop through each directory in the SOURCE_DIR
for dir in "$SOURCE_DIR"/*; do
    if [ -d "$dir" ]; then
        # Extracting just the name of the directory
        dir_name=$(basename "$dir")

        # Create a symbolic link in the destination directory
        ln -sfn "$dir" "$DEST_DIR/$dir_name"
    fi
done

echo "Symbolic links created successfully."
