# Powerlevel10k Setup Guide

This guide will help you install and configure Powerlevel10k with the exact theme preferences already configured in this repository.

## Prerequisites

1. **Zsh** - Should be your default shell
2. **Oh My Zsh** - Required for this setup method
3. **A Nerd Font** - Required for icons and special characters

## Installation Steps

### 1. Install a Nerd Font

Powerlevel10k requires a Nerd Font to display icons properly.

**Recommended: MesloLGS NF (Automatic)**
```bash
# These fonts are automatically installed by p10k configure
# If you need to install manually:
# https://github.com/romkatv/powerlevel10k#manual-font-installation
```

**Alternative: Install via Homebrew**
```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
# or
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font
```

**Configure Terminal/iTerm2:**
- **iTerm2**: Preferences → Profiles → Text → Font → Select "MesloLGS NF"
- **macOS Terminal**: Preferences → Profiles → Font → Change → Select "MesloLGS NF"

### 2. Install Oh My Zsh (if not already installed)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Install Powerlevel10k Theme

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 4. Configure Zsh to Use Powerlevel10k

Add or update these lines in your `~/.zshrc`:

```bash
# Set theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load Powerlevel10k configuration (at the end of .zshrc)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

**Important:** For instant prompt to work, add this to the TOP of your `~/.zshrc` (before anything else):

```bash
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
```

### 5. Use Your Pre-configured Settings

Instead of running the configuration wizard, use your existing configuration:

```bash
# Copy the pre-configured p10k configuration
cp ~/.dotfiles/terminal/p10k.zsh ~/.p10k.zsh

# Reload your shell
exec zsh
```

## Your Current Configuration

Your Powerlevel10k setup includes:

- **Instant prompt** - Fast shell startup
- **Oh My Zsh integration** - Works seamlessly with OMZ
- **Custom prompt segments** - Optimized for your workflow
- **Icon support** - Full Nerd Font icon support

## Customization

### Option 1: Reconfigure with Wizard
If you want to change your theme settings:
```bash
p10k configure
```

This will guide you through:
- Diamond icons vs arrows vs slanted separators
- Prompt style (Rainbow, Pure, Lean, etc.)
- Character set (Unicode vs ASCII)
- Prompt colors
- Prompt flow (one line vs two lines)
- Prompt spacing
- Icons (many vs few)
- Prompt height (compact vs spacious)
- Transient prompt

### Option 2: Edit Configuration Directly
```bash
# Edit the configuration file
vim ~/.p10k.zsh

# Or use your preferred editor
code ~/.p10k.zsh
```

Key sections to customize:
- `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS` - Left side prompt segments
- `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS` - Right side prompt segments
- Color settings (search for `_FOREGROUND` and `_BACKGROUND`)
- Icon settings (search for `_VISUAL_IDENTIFIER`)

## Updating Powerlevel10k

```bash
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git pull
exec zsh
```

Or via Oh My Zsh:
```bash
omz update
```

## Troubleshooting

### Icons not displaying correctly
- Verify you have a Nerd Font installed
- Make sure your terminal is configured to use the Nerd Font
- Try running `p10k configure` and select "yes" when asked about icon support

### Prompt looks broken
```bash
# Reconfigure from scratch
p10k configure
```

### Slow shell startup
- Powerlevel10k uses instant prompt to be fast
- Make sure the instant prompt block is at the TOP of ~/.zshrc
- Check for slow commands before the instant prompt block

### Colors look wrong
- Ensure your terminal supports 256 colors
- Check `echo $TERM` - should be `xterm-256color` or similar
- In iTerm2: Preferences → Profiles → Terminal → Report Terminal Type

## Restoring Your Configuration

If you've reconfigured and want to restore your original settings:

```bash
# Restore from dotfiles
cp ~/.dotfiles/terminal/p10k.zsh ~/.p10k.zsh
exec zsh
```

## Additional Resources

- [Powerlevel10k GitHub](https://github.com/romkatv/powerlevel10k)
- [Configuration Options](https://github.com/romkatv/powerlevel10k#configuration)
- [FAQ](https://github.com/romkatv/powerlevel10k#faq)
- [Troubleshooting](https://github.com/romkatv/powerlevel10k#troubleshooting)

## Integration with Other Tools

### Tmux
If using tmux, add to your `~/.tmux.conf`:
```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

### VSCode Integrated Terminal
The font should be configured in VSCode settings:
```json
{
  "terminal.integrated.fontFamily": "MesloLGS NF",
  "terminal.integrated.fontSize": 13
}
```

## Quick Reference

```bash
# Reconfigure theme
p10k configure

# Reload configuration
source ~/.p10k.zsh

# Edit configuration
vim ~/.p10k.zsh

# Update Powerlevel10k
cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && git pull

# Check if instant prompt is working
echo $POWERLEVEL9K_INSTANT_PROMPT
```
