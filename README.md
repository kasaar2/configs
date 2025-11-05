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

### 💻 Terminal
- iTerm2 profile for macOS

## Repository Structure

```
configs/
├── README.md
├── install.sh              # Automated installation script
├── shell/
│   ├── aliases.sh          # Command aliases
│   ├── functions.sh        # Shell functions
│   └── exports.sh          # Environment variables
├── vim/
│   └── vimrc              # Vim configuration
├── vscode/
│   ├── settings.json      # VSCode settings
│   ├── keybindings.json   # Custom keybindings
│   └── snippets/
│       └── python.json    # Python snippets
├── git/
│   ├── gitconfig          # Git configuration
│   └── gitignore_global   # Global gitignore
├── python/
│   └── data_analysis.yaml # Conda environment
└── terminal/
    └── iTermProfile.json  # iTerm2 profile
```

## Installation Details

The `install.sh` script will:

1. ✅ Back up existing configurations with timestamp
2. ✅ Create symlink for `~/.vimrc`
3. ✅ Add shell config sources to your `.zshrc` or `.bashrc`
4. ✅ Provide instructions for optional components

### What Gets Installed

| Component | Location | Method |
|-----------|----------|--------|
| Vim config | `~/.vimrc` | Symlink |
| Shell configs | Sourced in `.zshrc`/`.bashrc` | Source line |
| Git config | Manual (see below) | Copy |
| VSCode settings | Manual (see below) | Copy |

## Manual Setup Steps

### Git Configuration

```bash
# Copy and customize git config
cp git/gitconfig ~/.gitconfig
vim ~/.gitconfig  # Update name and email

# Set up global gitignore
cp git/gitignore_global ~/.gitignore_global
```

### VSCode Settings

```bash
# macOS
cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
cp vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
cp vscode/snippets/python.json ~/Library/Application\ Support/Code/User/snippets/python.json

# Linux
cp vscode/settings.json ~/.config/Code/User/settings.json
cp vscode/keybindings.json ~/.config/Code/User/keybindings.json
cp vscode/snippets/python.json ~/.config/Code/User/snippets/python.json
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
