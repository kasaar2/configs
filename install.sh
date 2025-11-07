#!/bin/bash

# Config Installation Script
# Installs dotfiles and configurations to your home directory

set -e  # Exit on error

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

# Installation flags
INSTALL_SHELL=false
INSTALL_VIM=false
INSTALL_GIT=false
INSTALL_PYTHON=false
INSTALL_VSCODE=false
INSTALL_P10K=false
INSTALL_ALL=false

# Parse command line arguments
show_help() {
    cat << EOF
Usage: ./install.sh [OPTIONS]

Install dotfiles and configurations selectively or all at once.

OPTIONS:
    --all           Install everything (default if no flags specified)
    --shell         Install shell configurations (aliases, functions, exports)
    --vim           Install Vim configuration
    --git           Install Git configuration
    --python        Set up Python/Conda environment
    --vscode        Install VSCode settings (interactive)
    --p10k          Install and configure Powerlevel10k theme
    --help, -h      Show this help message

EXAMPLES:
    ./install.sh                    # Install everything
    ./install.sh --all              # Install everything
    ./install.sh --shell --vim      # Install only shell and vim configs
    ./install.sh --git              # Install only git config

NOTES:
    - Existing files will be backed up to ~/.config_backup_TIMESTAMP
    - Shell configs will be sourced in your .zshrc or .bashrc
    - Git config requires manual editing to set your name/email
    - VSCode installation is interactive and platform-specific

EOF
}

# Parse arguments
if [ $# -eq 0 ]; then
    INSTALL_ALL=true
else
    while [[ $# -gt 0 ]]; do
        case $1 in
            --all)
                INSTALL_ALL=true
                shift
                ;;
            --shell)
                INSTALL_SHELL=true
                shift
                ;;
            --vim)
                INSTALL_VIM=true
                shift
                ;;
            --git)
                INSTALL_GIT=true
                shift
                ;;
            --python)
                INSTALL_PYTHON=true
                shift
                ;;
            --vscode)
                INSTALL_VSCODE=true
                shift
                ;;
            --p10k)
                INSTALL_P10K=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                echo "Error: Unknown option: $1"
                echo "Run './install.sh --help' for usage information."
                exit 1
                ;;
        esac
    done
fi

# If --all is specified, enable everything
if [ "$INSTALL_ALL" = true ]; then
    INSTALL_SHELL=true
    INSTALL_VIM=true
    INSTALL_GIT=true
    INSTALL_PYTHON=true
    INSTALL_VSCODE=true
    INSTALL_P10K=true
fi

echo "======================================"
echo "Config Installation Script"
echo "======================================"
echo "Repository: $REPO_DIR"
echo ""
echo "Installing:"
[ "$INSTALL_SHELL" = true ] && echo "  ✓ Shell configurations"
[ "$INSTALL_VIM" = true ] && echo "  ✓ Vim configuration"
[ "$INSTALL_GIT" = true ] && echo "  ✓ Git configuration"
[ "$INSTALL_PYTHON" = true ] && echo "  ✓ Python environment"
[ "$INSTALL_VSCODE" = true ] && echo "  ✓ VSCode settings"
[ "$INSTALL_P10K" = true ] && echo "  ✓ Powerlevel10k theme"
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

# Counter for installation steps
STEP=1
TOTAL_STEPS=$(( INSTALL_SHELL + INSTALL_VIM + INSTALL_GIT + INSTALL_PYTHON + INSTALL_VSCODE + INSTALL_P10K ))

# Install Vim config
if [ "$INSTALL_VIM" = true ]; then
    echo "[$STEP/$TOTAL_STEPS] Installing Vim configuration..."
    backup_if_exists "$HOME/.vimrc"
    create_symlink "$REPO_DIR/vim/vimrc" "$HOME/.vimrc"
    echo ""
    ((STEP++))
fi

# Install shell configs
if [ "$INSTALL_SHELL" = true ]; then
    echo "[$STEP/$TOTAL_STEPS] Installing shell configurations..."

    # Detect shell rc file
    SHELL_RC=""
    if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    else
        echo "  Warning: Could not detect shell rc file (.zshrc or .bashrc)"
        echo "  Please manually add the following lines to your shell rc file:"
        echo "    source $REPO_DIR/shell/exports.sh"
        echo "    source $REPO_DIR/shell/aliases.sh"
        echo "    source $REPO_DIR/shell/functions.sh"
        SHELL_RC=""
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
    ((STEP++))
fi

# Install Git config
if [ "$INSTALL_GIT" = true ]; then
    echo "[$STEP/$TOTAL_STEPS] Installing Git configuration..."

    backup_if_exists "$HOME/.gitconfig"
    backup_if_exists "$HOME/.gitignore_global"

    cp "$REPO_DIR/git/gitconfig" "$HOME/.gitconfig"
    cp "$REPO_DIR/git/gitignore_global" "$HOME/.gitignore_global"

    echo "  ✓ Copied gitconfig to ~/.gitconfig"
    echo "  ✓ Copied gitignore_global to ~/.gitignore_global"
    echo ""
    echo "  ⚠️  IMPORTANT: Edit ~/.gitconfig to set your name and email:"
    echo "      git config --global user.name \"Your Name\""
    echo "      git config --global user.email \"your.email@example.com\""
    echo ""
    ((STEP++))
fi

# Install Python environment
if [ "$INSTALL_PYTHON" = true ]; then
    echo "[$STEP/$TOTAL_STEPS] Setting up Python environment..."

    if command -v conda &> /dev/null; then
        read -p "  Create conda environment 'data-analysis'? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            conda env create -f "$REPO_DIR/python/data_analysis.yaml" || echo "  Note: Environment may already exist"
            echo "  ✓ Conda environment created"
            echo "  To activate: conda activate data-analysis"
        fi
    else
        echo "  ⚠️  Conda not found. Install Miniconda/Anaconda first."
        echo "  Then run: conda env create -f $REPO_DIR/python/data_analysis.yaml"
    fi
    echo ""
    ((STEP++))
fi

# Install VSCode settings
if [ "$INSTALL_VSCODE" = true ]; then
    echo "[$STEP/$TOTAL_STEPS] Installing VSCode settings..."

    VSCODE_USER_DIR=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        VSCODE_USER_DIR="$HOME/.config/Code/User"
    fi

    if [ -n "$VSCODE_USER_DIR" ] && [ -d "$VSCODE_USER_DIR" ]; then
        backup_if_exists "$VSCODE_USER_DIR/settings.json"
        backup_if_exists "$VSCODE_USER_DIR/keybindings.json"

        cp "$REPO_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
        cp "$REPO_DIR/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

        mkdir -p "$VSCODE_USER_DIR/snippets"
        cp "$REPO_DIR/vscode/snippets/python.json" "$VSCODE_USER_DIR/snippets/python.json"

        echo "  ✓ Copied settings.json"
        echo "  ✓ Copied keybindings.json"
        echo "  ✓ Copied Python snippets"
    else
        echo "  ⚠️  VSCode user directory not found."
        echo "  Manual installation required. See README.md for instructions."
    fi
    echo ""
    ((STEP++))
fi

# Install Powerlevel10k
if [ "$INSTALL_P10K" = true ]; then
    echo "[$STEP/$TOTAL_STEPS] Installing Powerlevel10k theme..."

    if [ -f "$REPO_DIR/terminal/setup_p10k.sh" ]; then
        read -p "  Run Powerlevel10k setup script now? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            bash "$REPO_DIR/terminal/setup_p10k.sh"
        else
            echo "  ⚠️  Skipped Powerlevel10k installation"
            echo "  To install later, run: $REPO_DIR/terminal/setup_p10k.sh"
        fi
    else
        echo "  ⚠️  Powerlevel10k setup script not found"
        echo "  See $REPO_DIR/terminal/POWERLEVEL10K_SETUP.md for manual setup"
    fi
    echo ""
    ((STEP++))
fi

echo "======================================"
echo "Installation Complete!"
echo "======================================"

if [ -d "$BACKUP_DIR" ]; then
    echo "Backups saved to: $BACKUP_DIR"
    echo ""
fi

# Show next steps based on what was installed
if [ "$INSTALL_SHELL" = true ] && [ -n "$SHELL_RC" ]; then
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source $SHELL_RC"
    [ "$INSTALL_GIT" = true ] && echo "  2. Update Git config with your name/email (see above)"
    [ "$INSTALL_PYTHON" = true ] && echo "  3. Activate conda environment: conda activate data-analysis"
fi

echo ""
echo "Run './install.sh --help' to see all installation options."
echo ""
