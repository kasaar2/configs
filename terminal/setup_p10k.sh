#!/usr/bin/env bash

# Powerlevel10k Setup Script
# Automates installation and configuration of Powerlevel10k with your custom settings

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

echo "========================================"
echo "  Powerlevel10k Setup"
echo "========================================"
echo ""

# Check if running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    print_warning "Unsupported OS: $OSTYPE"
    OS="unknown"
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# 1. Check prerequisites
echo "Checking prerequisites..."

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    print_error "Zsh is not installed"
    print_info "Install with: brew install zsh (macOS) or apt-get install zsh (Linux)"
    exit 1
fi
print_success "Zsh is installed"

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_warning "Oh My Zsh is not installed"
    read -p "Do you want to install Oh My Zsh now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed"
    else
        print_error "Oh My Zsh is required. Exiting."
        exit 1
    fi
else
    print_success "Oh My Zsh is installed"
fi

# 2. Install Nerd Font
echo ""
echo "Checking for Nerd Font..."

if [[ "$OS" == "macos" ]]; then
    if command -v brew &> /dev/null; then
        # Check if any Nerd Font is installed
        if ! brew list --cask | grep -q "nerd-font"; then
            print_warning "No Nerd Font detected"
            read -p "Do you want to install MesloLGS Nerd Font? (recommended) (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_info "Installing MesloLGS Nerd Font..."
                brew tap homebrew/cask-fonts
                brew install --cask font-meslo-lg-nerd-font
                print_success "Nerd Font installed"
                print_warning "IMPORTANT: Configure your terminal to use 'MesloLGS NF' font"
                print_info "  iTerm2: Preferences → Profiles → Text → Font"
                print_info "  Terminal: Preferences → Profiles → Font"
            else
                print_warning "Skipping font installation - icons may not display correctly"
            fi
        else
            print_success "Nerd Font is installed"
        fi
    else
        print_warning "Homebrew not found - cannot auto-install fonts"
        print_info "Install a Nerd Font manually from: https://www.nerdfonts.com/font-downloads"
    fi
else
    print_info "On Linux, install a Nerd Font manually:"
    print_info "  1. Download from https://www.nerdfonts.com/font-downloads"
    print_info "  2. Extract to ~/.local/share/fonts/"
    print_info "  3. Run: fc-cache -fv"
fi

# 3. Install Powerlevel10k
echo ""
echo "Installing Powerlevel10k theme..."

P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if [ -d "$P10K_DIR" ]; then
    print_info "Powerlevel10k already installed"
    read -p "Do you want to update it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Updating Powerlevel10k..."
        cd "$P10K_DIR"
        git pull
        print_success "Powerlevel10k updated"
    fi
else
    print_info "Cloning Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    print_success "Powerlevel10k installed"
fi

# 4. Configure .zshrc
echo ""
echo "Configuring .zshrc..."

ZSHRC="$HOME/.zshrc"

# Backup existing .zshrc
if [ -f "$ZSHRC" ]; then
    backup_file="${ZSHRC}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$ZSHRC" "$backup_file"
    print_info "Backed up existing .zshrc to $backup_file"
fi

# Check if instant prompt is already configured
if ! grep -q "p10k-instant-prompt" "$ZSHRC" 2>/dev/null; then
    print_info "Adding instant prompt to .zshrc..."

    # Create temp file with instant prompt at the top
    temp_file=$(mktemp)

    cat > "$temp_file" << 'EOF'
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

EOF

    # Append existing .zshrc content if it exists
    if [ -f "$ZSHRC" ]; then
        cat "$ZSHRC" >> "$temp_file"
    fi

    mv "$temp_file" "$ZSHRC"
    print_success "Added instant prompt configuration"
fi

# Ensure ZSH_THEME is set to powerlevel10k
if grep -q '^ZSH_THEME=' "$ZSHRC" 2>/dev/null; then
    if ! grep -q '^ZSH_THEME="powerlevel10k/powerlevel10k"' "$ZSHRC"; then
        print_info "Updating ZSH_THEME..."
        # Comment out existing theme and add p10k
        sed -i.tmp 's/^ZSH_THEME=/#ZSH_THEME=/' "$ZSHRC"

        # Add p10k theme after the commented line
        awk '/^#ZSH_THEME=/ && !found {print; print "ZSH_THEME=\"powerlevel10k/powerlevel10k\""; found=1; next} 1' "$ZSHRC" > "$ZSHRC.tmp"
        mv "$ZSHRC.tmp" "$ZSHRC"
        rm -f "$ZSHRC.tmp"
        print_success "Updated ZSH_THEME"
    fi
else
    print_info "Adding ZSH_THEME..."
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
    print_success "Added ZSH_THEME"
fi

# Ensure p10k config is sourced at the end
if ! grep -q 'source.*\.p10k\.zsh' "$ZSHRC" 2>/dev/null; then
    print_info "Adding p10k config source line..."
    cat >> "$ZSHRC" << 'EOF'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF
    print_success "Added p10k config source"
fi

# 5. Copy pre-configured p10k settings
echo ""
echo "Installing your pre-configured theme settings..."

P10K_CONFIG="$HOME/.p10k.zsh"
P10K_SOURCE="$SCRIPT_DIR/p10k.zsh"

if [ -f "$P10K_SOURCE" ]; then
    if [ -f "$P10K_CONFIG" ]; then
        # Backup existing config
        backup_file="${P10K_CONFIG}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$P10K_CONFIG" "$backup_file"
        print_info "Backed up existing .p10k.zsh to $backup_file"
    fi

    cp "$P10K_SOURCE" "$P10K_CONFIG"
    print_success "Installed pre-configured p10k settings"
else
    print_error "Could not find p10k.zsh in $SCRIPT_DIR"
    print_info "You'll need to run 'p10k configure' to set up your theme"
fi

# 6. Final steps
echo ""
echo "========================================"
echo "  Setup Complete!"
echo "========================================"
echo ""
print_success "Powerlevel10k has been installed and configured"
echo ""
print_info "Next steps:"
echo "  1. Make sure your terminal is using a Nerd Font (MesloLGS NF recommended)"
if [[ "$OS" == "macos" ]]; then
    echo "     iTerm2: Preferences → Profiles → Text → Font → MesloLGS NF"
    echo "     Terminal: Preferences → Profiles → Font → MesloLGS NF"
fi
echo "  2. Restart your terminal or run: exec zsh"
echo "  3. If the prompt looks wrong, run: p10k configure"
echo ""
print_info "To customize your prompt later:"
echo "  - Run 'p10k configure' to use the configuration wizard"
echo "  - Or edit ~/.p10k.zsh directly"
echo ""
print_info "Documentation: $SCRIPT_DIR/POWERLEVEL10K_SETUP.md"
echo ""

# Offer to reload shell
read -p "Do you want to reload your shell now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_info "Reloading shell..."
    exec zsh
fi
