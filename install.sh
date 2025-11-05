#!/bin/bash

# Config Installation Script
# Installs vimrc and shell configurations to your home directory

set -e  # Exit on error

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

echo "======================================"
echo "Config Installation Script"
echo "======================================"
echo "Repository: $REPO_DIR"
echo ""

# Function to backup a file if it exists
backup_if_exists() {
    local file=$1
    if [ -f "$file" ] || [ -L "$file" ]; then
        echo "  Backing up existing $(basename $file) to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        cp -L "$file" "$BACKUP_DIR/" || true
    fi
}

# Function to create symlink
create_symlink() {
    local source=$1
    local target=$2

    # Remove existing file/symlink
    rm -f "$target"

    # Create symlink
    ln -s "$source" "$target"
    echo "  ✓ Linked $(basename $target)"
}

# Install vimrc
echo "[1/2] Installing vimrc..."
backup_if_exists "$HOME/.vimrc"
create_symlink "$REPO_DIR/vim/vimrc" "$HOME/.vimrc"
echo ""

# Install shell configs
echo "[2/2] Installing shell configurations..."

# Detect shell rc file
SHELL_RC=""
if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    echo "  Warning: Could not detect shell rc file (.zshrc or .bashrc)"
    echo "  Please manually add the following lines to your shell rc file:"
    echo "    source $REPO_DIR/shell/aliases.sh"
    echo "    source $REPO_DIR/shell/functions.sh"
    echo "    source $REPO_DIR/shell/exports.sh"
fi

if [ -n "$SHELL_RC" ]; then
    # Check if already sourced
    if grep -q "configs/shell" "$SHELL_RC" 2>/dev/null; then
        echo "  ✓ Shell configs already sourced in $(basename $SHELL_RC)"
    else
        backup_if_exists "$SHELL_RC"
        echo "" >> "$SHELL_RC"
        echo "# Source custom configs (added by install.sh)" >> "$SHELL_RC"
        echo "source $REPO_DIR/shell/exports.sh" >> "$SHELL_RC"
        echo "source $REPO_DIR/shell/aliases.sh" >> "$SHELL_RC"
        echo "source $REPO_DIR/shell/functions.sh" >> "$SHELL_RC"
        echo "  ✓ Added shell configs to $(basename $SHELL_RC)"
    fi
fi

echo ""
echo "======================================"
echo "Installation Complete!"
echo "======================================"

if [ -d "$BACKUP_DIR" ]; then
    echo "Backups saved to: $BACKUP_DIR"
fi

echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source $SHELL_RC"
echo "  2. (Optional) Set up Git config:"
echo "       cp git/gitconfig ~/.gitconfig"
echo "       cp git/gitignore_global ~/.gitignore_global"
echo "       vim ~/.gitconfig  # Update name and email"
echo "  3. (Optional) Install VSCode settings from vscode/ directory"
echo "  4. (Optional) Create conda environment: conda env create -f python/data_analysis.yaml"
echo ""
