# Personal Development Environment Configs

Automated dotfiles and development environment setup for consistent configuration across systems.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/kasaar2/configs.git ~/.dotfiles
cd ~/.dotfiles

# Run the installer
./install.sh

# Reload your shell
source ~/.zshrc  # or ~/.bashrc
```

## What's Included

### 🐚 Shell Configuration
- **aliases.sh** - Convenient shortcuts for common commands
- **functions.sh** - Useful shell functions (git helpers, file utilities)
- **exports.sh** - Environment variables and shell settings

### 📝 Vim Configuration
- Clean, focused vimrc with Python-optimized settings
- Smart search, syntax highlighting, and status line
- 4-space tabs for Python, 2-space for text files

### 🎨 VSCode Setup
- Python development settings (Black formatter, import sorting)
- Custom color scheme for selections and search
- Minimalist UI configuration
- Python code snippets for data analysis

### 🔧 Git Configuration
- Sensible git defaults and useful aliases
- Global gitignore for common files
- Enhanced diff and merge settings

### 🐍 Python Environment
- Conda environment specification for data analysis
- Pre-configured with: pandas, numpy, matplotlib, seaborn, scikit-learn, jupyter
- **pyproject.toml** - Black, isort, pytest, mypy, pylint configurations
- **.flake8** - Linting configuration compatible with Black

### 💻 Terminal
- **iTerm2 profile** for macOS
- **tmux.conf** - Feature-rich tmux configuration with vim keybindings

### 🔐 SSH Configuration
- **config.template** - SSH config template with GitHub, GitLab examples

### 📚 Documentation
- **TOOLS.md** - Comprehensive guide to 21+ recommended development tools

## Repository Structure

```
configs/
├── README.md                  # This file
├── TOOLS.md                   # Recommended development tools guide
├── install.sh                 # Automated installation script (with flags!)
├── uninstall.sh              # Uninstall and restore backups
├── shell/
│   ├── aliases.sh            # Command aliases
│   ├── functions.sh          # Shell functions
│   └── exports.sh            # Environment variables
├── vim/
│   └── vimrc                # Vim configuration
├── vscode/
│   ├── settings.json        # VSCode settings
│   ├── keybindings.json     # Custom keybindings
│   └── snippets/
│       └── python.json      # Python snippets
├── git/
│   ├── gitconfig            # Git configuration
│   └── gitignore_global     # Global gitignore
├── python/
│   ├── data_analysis.yaml   # Conda environment
│   ├── pyproject.toml       # Python tool configs
│   └── .flake8              # Flake8 linter config
├── ssh/
│   └── config.template      # SSH configuration template
└── terminal/
    ├── iTermProfile.json    # iTerm2 profile
    └── tmux.conf            # Tmux configuration
```

## Installation Details

### Selective Installation (NEW!)

The enhanced `install.sh` script now supports selective installation:

```bash
# Install everything (default)
./install.sh

# Install only what you need
./install.sh --shell --vim      # Just shell and vim
./install.sh --git              # Only git configuration
./install.sh --python           # Python environment setup

# See all options
./install.sh --help
```

**Available Options:**
- `--all` - Install everything (default if no flags)
- `--shell` - Shell configurations (aliases, functions, exports)
- `--vim` - Vim configuration
- `--git` - Git configuration (automated)
- `--python` - Python/Conda environment (interactive)
- `--vscode` - VSCode settings (automated, platform-aware)

**The script will:**
1. ✅ Back up existing configurations with timestamp
2. ✅ Create symlinks or copy files as appropriate
3. ✅ Detect your shell (.zshrc or .bashrc)
4. ✅ Handle platform differences (macOS vs Linux)
5. ✅ Provide clear feedback and next steps

### Uninstalling

```bash
# Remove configurations and optionally restore from backup
./uninstall.sh
```

### What Gets Installed

| Component | Location | Method | Flag |
|-----------|----------|--------|------|
| Vim config | `~/.vimrc` | Symlink | `--vim` |
| Shell configs | Sourced in `.zshrc`/`.bashrc` | Source lines | `--shell` |
| Git config | `~/.gitconfig`, `~/.gitignore_global` | Copy | `--git` |
| VSCode settings | Platform-specific User directory | Copy | `--vscode` |
| Python env | Conda environment | Interactive | `--python` |

## Additional Setup

### Git Configuration

Git config is now automated with `./install.sh --git`, but you'll need to set your identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Or edit `~/.gitconfig` directly after installation.

### SSH Configuration

```bash
# Copy template and customize
cp ssh/config.template ~/.ssh/config
mkdir -p ~/.ssh/sockets
chmod 700 ~/.ssh && chmod 600 ~/.ssh/config

# Generate SSH key if needed
ssh-keygen -t ed25519 -C "your.email@example.com"
```

### Tmux Configuration

```bash
# Create symlink
ln -s ~/.dotfiles/terminal/tmux.conf ~/.tmux.conf

# Install Tmux Plugin Manager (optional)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Inside tmux, press prefix + I to install plugins
```

### VSCode Settings

VSCode settings are now automated with `./install.sh --vscode`. The script will:
- Detect your platform (macOS or Linux)
- Copy settings, keybindings, and snippets to the correct location
- Back up existing settings

Manual installation (if needed):
```bash
# macOS
cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Linux
cp vscode/settings.json ~/.config/Code/User/settings.json
```

### Python Environment

```bash
# Create conda environment
conda env create -f python/data_analysis.yaml

# Activate environment
conda activate data-analysis
```

### iTerm2 Profile (macOS only)

1. Open iTerm2
2. Go to Preferences → Profiles
3. Click "Other Actions" → Import JSON Profiles
4. Select `terminal/iTermProfile.json`

## Key Features

### Shell Aliases

```bash
# Navigation
u          # cd ..
uu         # cd ../..
p          # pwd

# Git shortcuts
gs         # git status
gd         # git diff
gc         # git commit -v
glog       # git log --graph --oneline

# Python/Conda
ca         # conda activate
ip         # ipython
jpn        # jupyter notebook

# Quick config edits
ez         # edit .zshrc
sz         # source .zshrc
ev         # edit .vimrc
```

### Shell Functions

```bash
gm This is a commit message  # Git commit without quotes
git-frequent                  # Show most used Python methods in repo
line <file> <start> <count>  # Print specific lines from file
```

## Customization

### Local Overrides

Create `~/.local_aliases.sh` for machine-specific aliases that won't be committed:

```bash
# Add to your .zshrc/.bashrc
[ -f ~/.local_aliases.sh ] && source ~/.local_aliases.sh
```

### Extending Configurations

Feel free to fork and customize:
- Add your own aliases to `shell/aliases.sh`
- Extend vim plugins in `vim/vimrc`
- Customize VSCode settings in `vscode/settings.json`

## Platform Support

- ✅ macOS (primary)
- ✅ Linux
- ⚠️  Windows (via WSL)

## Requirements

- Git
- Bash or Zsh
- Vim/Neovim (optional)
- VSCode (optional)
- Conda/Miniconda (optional, for Python environment)

## Recommended Tools

See **[TOOLS.md](TOOLS.md)** for a comprehensive guide to recommended development tools, including:

- **Essential tools**: Homebrew, Git, Neovim, Miniconda
- **Shell enhancements**: Zsh, Oh My Zsh, tmux, fzf
- **Modern CLI tools**: ripgrep, fd, bat, exa, delta
- **Git tools**: GitHub CLI, tig, delta
- **Python tools**: Black, pytest, ipython, jupyter
- **Platform-specific**: iTerm2, Alfred, Rectangle (macOS)

Each tool includes installation instructions and usage examples. Tools are categorized by priority (Essential, High Value, Nice to Have) to help you decide what to install first.

## Troubleshooting

### Shell configs not loading

Make sure the source lines are added to your shell rc file:

```bash
# Check if lines are present
grep "configs/shell" ~/.zshrc  # or ~/.bashrc
```

### Vim config not working

Verify the symlink:

```bash
ls -la ~/.vimrc
# Should point to your configs/vim/vimrc
```

### Updating configs

```bash
cd ~/.dotfiles
git pull origin main
# Re-run install.sh if needed
```

## Contributing

This is a personal config repository, but feel free to:
- Open issues for bugs or suggestions
- Fork and adapt for your own use
- Submit PRs for improvements

## License

MIT License - Use freely for your own configurations!

## Author

Your Name - [@kasaar2](https://github.com/kasaar2)

---

**Pro tip**: Star this repo to easily find it later, and watch for updates! 🌟
