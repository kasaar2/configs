#!/bin/bash

# Config Uninstall Script
# Removes installed configurations and optionally restores from backups

set -e  # Exit on error

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "Config Uninstall Script"
echo "======================================"
echo ""

# Find available backups
BACKUPS=($(ls -dt $HOME/.config_backup_* 2>/dev/null || true))

if [ ${#BACKUPS[@]} -eq 0 ]; then
    echo "⚠️  No backup directories found."
    echo "Proceeding with uninstall only (no restoration)."
    echo ""
    RESTORE=false
else
    echo "Found ${#BACKUPS[@]} backup(s):"
    for i in "${!BACKUPS[@]}"; do
        echo "  [$((i+1))] $(basename ${BACKUPS[$i]})"
    done
    echo ""

    read -p "Restore from backup? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        RESTORE=true

        if [ ${#BACKUPS[@]} -gt 1 ]; then
            read -p "Which backup? (1-${#BACKUPS[@]}) " BACKUP_CHOICE
            BACKUP_DIR="${BACKUPS[$((BACKUP_CHOICE-1))]}"
        else
            BACKUP_DIR="${BACKUPS[0]}"
        fi

        echo "Will restore from: $(basename $BACKUP_DIR)"
        echo ""
    else
        RESTORE=false
    fi
fi

# Function to safely remove symlink or file
safe_remove() {
    local file=$1
    if [ -L "$file" ]; then
        echo "  ✓ Removed symlink: $(basename $file)"
        rm "$file"
    elif [ -f "$file" ]; then
        echo "  ⚠️  File exists but is not a symlink: $(basename $file)"
        read -p "  Remove it? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm "$file"
            echo "  ✓ Removed: $(basename $file)"
        fi
    fi
}

# Function to restore from backup
restore_file() {
    local filename=$1
    local target=$2

    if [ -f "$BACKUP_DIR/$filename" ]; then
        cp "$BACKUP_DIR/$filename" "$target"
        echo "  ✓ Restored: $filename"
        return 0
    fi
    return 1
}

echo "Step 1: Removing Vim configuration..."
safe_remove "$HOME/.vimrc"
if [ "$RESTORE" = true ]; then
    restore_file ".vimrc" "$HOME/.vimrc" || echo "  No backup found for .vimrc"
fi
echo ""

echo "Step 2: Removing shell configuration sources..."

# Detect shell rc file
SHELL_RC=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
fi

if [ -n "$SHELL_RC" ]; then
    if grep -q "configs/shell" "$SHELL_RC" 2>/dev/null; then
        # Remove the lines added by install.sh
        # Create a temp file without the config lines
        grep -v "configs/shell" "$SHELL_RC" | grep -v "Source custom configs" > "${SHELL_RC}.tmp"
        mv "${SHELL_RC}.tmp" "$SHELL_RC"
        echo "  ✓ Removed config sources from $(basename $SHELL_RC)"

        if [ "$RESTORE" = true ]; then
            restore_file "$(basename $SHELL_RC)" "$SHELL_RC" || echo "  No backup found for $(basename $SHELL_RC)"
        fi
    else
        echo "  No config sources found in $(basename $SHELL_RC)"
    fi
else
    echo "  Shell rc file not found"
fi
echo ""

echo "Step 3: Removing Git configuration..."
if [ -f "$HOME/.gitconfig" ]; then
    # Check if it's our config (has the placeholder name/email)
    if grep -q "Your Name" "$HOME/.gitconfig" 2>/dev/null || [ "$RESTORE" = true ]; then
        read -p "  Remove ~/.gitconfig? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            safe_remove "$HOME/.gitconfig"
            if [ "$RESTORE" = true ]; then
                restore_file ".gitconfig" "$HOME/.gitconfig" || echo "  No backup found for .gitconfig"
            fi
        fi
    else
        echo "  Skipping .gitconfig (appears to be customized)"
    fi
else
    echo "  No .gitconfig found"
fi

if [ -f "$HOME/.gitignore_global" ]; then
    read -p "  Remove ~/.gitignore_global? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        safe_remove "$HOME/.gitignore_global"
        if [ "$RESTORE" = true ]; then
            restore_file ".gitignore_global" "$HOME/.gitignore_global" || echo "  No backup found for .gitignore_global"
        fi
    fi
fi
echo ""

echo "======================================"
echo "Uninstall Complete!"
echo "======================================"
echo ""
echo "Notes:"
echo "  - Shell changes will take effect after restarting your terminal"
echo "  - VSCode settings (if installed) were not removed"
echo "  - Python conda environment (if created) was not removed"
echo "  - To remove conda env: conda env remove -n data-analysis"
echo ""

if [ "$RESTORE" = true ]; then
    echo "Files restored from: $BACKUP_DIR"
    echo "You may want to keep this backup or delete it manually."
fi

echo ""
