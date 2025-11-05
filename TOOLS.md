# Recommended Development Tools

This document lists recommended tools to enhance your development environment. These tools complement the configurations in this repository.

## Table of Contents

- [Essential Tools](#essential-tools)
- [Shell & Terminal](#shell--terminal)
- [Text Editors](#text-editors)
- [Git Tools](#git-tools)
- [Python Development](#python-development)
- [Modern CLI Replacements](#modern-cli-replacements)
- [Platform-Specific Tools](#platform-specific-tools)

---

## Essential Tools

### 1. Homebrew (macOS/Linux)

**What it is**: Package manager for macOS and Linux

**Install**:
```bash
# macOS and Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Why**: Makes installing and managing development tools trivial

---

### 2. Git

**What it is**: Version control system

**Install**:
```bash
# macOS (via Homebrew)
brew install git

# Ubuntu/Debian
sudo apt-get install git

# Already included in most systems
```

**Post-install**: Configure with your identity
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## Shell & Terminal

### 3. Zsh + Oh My Zsh (Optional)

**What it is**: Enhanced shell with plugins and themes

**Install Zsh**:
```bash
# macOS
brew install zsh

# Ubuntu/Debian
sudo apt-get install zsh

# Set as default
chsh -s $(which zsh)
```

**Install Oh My Zsh** (optional):
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Why**: Better autocomplete, git integration, and customization

---

### 4. iTerm2 (macOS only)

**What it is**: Terminal emulator replacement for Terminal.app

**Install**:
```bash
brew install --cask iterm2
```

**Why**: Split panes, better search, profiles, hotkey window

**Configuration**: Import the profile from `terminal/iTermProfile.json`

---

### 5. tmux

**What it is**: Terminal multiplexer for managing multiple shell sessions

**Install**:
```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt-get install tmux
```

**Why**: Persistent sessions, split panes, detach/reattach

**Quick Start**:
```bash
tmux              # Start new session
Ctrl+b %          # Split vertically
Ctrl+b "          # Split horizontally
Ctrl+b d          # Detach
tmux attach       # Reattach
```

---

## Text Editors

### 6. Neovim

**What it is**: Modern Vim fork with better defaults

**Install**:
```bash
# macOS
brew install neovim

# Ubuntu/Debian (latest)
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

**Alias**: Already aliased in `shell/aliases.sh` as `vim` and `v`

**Why**: Better plugin architecture, async support, built-in LSP

---

### 7. Visual Studio Code

**What it is**: Modern code editor with excellent Python support

**Install**:
```bash
# macOS
brew install --cask visual-studio-code

# Ubuntu/Debian - Download from https://code.visualstudio.com/
```

**Recommended Extensions** (install after setup):
```bash
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension vscodevim.vim
code --install-extension GitHub.copilot
code --install-extension eamodio.gitlens
```

**Configuration**: Install settings with `./install.sh --vscode`

---

## Git Tools

### 8. GitHub CLI (gh)

**What it is**: Official GitHub command-line tool

**Install**:
```bash
# macOS
brew install gh

# Ubuntu/Debian
sudo apt-get install gh
```

**Authenticate**:
```bash
gh auth login
```

**Why**: Create PRs, manage issues, view repos from terminal

**Usage**:
```bash
gh pr create                    # Create PR
gh pr list                      # List PRs
gh issue list                   # List issues
gh repo view                    # View repo
```

---

### 9. tig

**What it is**: Text-mode interface for Git

**Install**:
```bash
# macOS
brew install tig

# Ubuntu/Debian
sudo apt-get install tig
```

**Why**: Browse git history interactively

**Usage**:
```bash
tig                 # Browse history
tig status          # Interactive git status
tig blame FILE      # Git blame interface
```

---

### 10. diff-so-fancy / delta

**What it is**: Better git diff output

**Install delta** (recommended):
```bash
# macOS
brew install git-delta

# Ubuntu/Debian
wget https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb
sudo dpkg -i git-delta_0.16.5_amd64.deb
```

**Configure** (add to `~/.gitconfig`):
```ini
[core]
    pager = delta

[delta]
    navigate = true
    light = false
    side-by-side = true

[interactive]
    diffFilter = delta --color-only
```

**Why**: Syntax highlighting and better diff visualization

---

## Python Development

### 11. Miniconda / Anaconda

**What it is**: Python distribution and package manager

**Install Miniconda** (lightweight, recommended):
```bash
# macOS
brew install --cask miniconda

# Linux
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

**Create environment**:
```bash
conda env create -f python/data_analysis.yaml
conda activate data-analysis
```

**Why**: Isolated Python environments, easy package management

---

### 12. Poetry (Alternative to Conda)

**What it is**: Modern Python dependency management

**Install**:
```bash
curl -sSL https://install.python-poetry.org | python3 -
```

**Why**: Better dependency resolution, lock files, project packaging

---

### 13. IPython / Jupyter

**What it is**: Interactive Python shell and notebooks

**Install** (included in conda env, or via pip):
```bash
pip install ipython jupyter
```

**Aliases**: Already set up in `shell/aliases.sh`
- `ip` → ipython
- `jpn` → jupyter notebook
- `ipn` → ipython with numpy
- `ipp` → ipython with numpy and pandas

---

### 14. Black (Code Formatter)

**What it is**: Opinionated Python code formatter

**Install**:
```bash
pip install black
# Or included in data-analysis conda env
```

**VSCode**: Already configured in `vscode/settings.json`

**Why**: Consistent code style, no more formatting debates

---

### 15. pytest

**What it is**: Python testing framework

**Install**:
```bash
pip install pytest pytest-cov
```

**Usage**:
```bash
pytest                          # Run all tests
pytest -v                       # Verbose
pytest --cov=mymodule          # With coverage
```

---

## Modern CLI Replacements

These tools are drop-in replacements for common Unix commands with better defaults and output.

### 16. ripgrep (rg)

**What it is**: Fast grep alternative

**Install**:
```bash
# macOS
brew install ripgrep

# Ubuntu/Debian
sudo apt-get install ripgrep
```

**Why**: 10-100x faster than grep, respects .gitignore

**Usage**:
```bash
rg "search term"                # Search recursively
rg -i "case insensitive"        # Case insensitive
rg -t py "only python"          # Search only Python files
```

---

### 17. fd

**What it is**: Fast find alternative

**Install**:
```bash
# macOS
brew install fd

# Ubuntu/Debian
sudo apt-get install fd-find
```

**Why**: Faster, simpler syntax, respects .gitignore

**Usage**:
```bash
fd pattern                      # Find files matching pattern
fd -e py                        # Find Python files
fd -H hidden                    # Include hidden files
```

---

### 18. bat

**What it is**: cat with syntax highlighting

**Install**:
```bash
# macOS
brew install bat

# Ubuntu/Debian
sudo apt-get install bat
```

**Why**: Syntax highlighting, line numbers, git integration

**Usage**:
```bash
bat file.py                     # View with highlighting
bat -n file.py                  # With line numbers
```

**Optional alias** (add to `shell/aliases.sh`):
```bash
alias cat='bat'
```

---

### 19. exa (or lsd)

**What it is**: Modern ls replacement

**Install exa**:
```bash
# macOS
brew install exa

# Ubuntu/Debian
sudo apt-get install exa
```

**Why**: Colors, icons, git status, tree view

**Usage**:
```bash
exa                             # Better ls
exa -l                          # Long format
exa -T                          # Tree view
exa -la --git                   # With git status
```

**Optional alias**:
```bash
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
```

---

### 20. htop

**What it is**: Interactive process viewer (better top)

**Install**:
```bash
# macOS
brew install htop

# Ubuntu/Debian
sudo apt-get install htop
```

**Why**: Better visualization, easier to use, sorting

---

### 21. fzf

**What it is**: Fuzzy finder for command line

**Install**:
```bash
# macOS
brew install fzf
$(brew --prefix)/opt/fzf/install

# Ubuntu/Debian
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

**Why**: Fuzzy search files, command history, anything

**Usage**:
```bash
Ctrl+R              # Fuzzy search command history
Ctrl+T              # Fuzzy search files
Alt+C               # Fuzzy cd into directory
vim $(fzf)          # Open file in vim after fuzzy search
```

---

## Platform-Specific Tools

### macOS

**Rectangle** - Window management
```bash
brew install --cask rectangle
```

**Alfred** - Spotlight replacement
```bash
brew install --cask alfred
```

**Karabiner-Elements** - Keyboard customization
```bash
brew install --cask karabiner-elements
```

### Linux

**i3wm** - Tiling window manager
```bash
sudo apt-get install i3
```

**rofi** - Application launcher
```bash
sudo apt-get install rofi
```

---

## Installation Priority

### Tier 1: Essential (Install First)
1. Homebrew (macOS/Linux)
2. Git
3. Neovim or VSCode
4. Miniconda/Anaconda
5. ripgrep

### Tier 2: High Value (Install Soon)
6. tmux
7. fzf
8. GitHub CLI (gh)
9. bat
10. fd

### Tier 3: Nice to Have
11. tig
12. delta
13. exa
14. htop
15. iTerm2 (macOS)

---

## Quick Install Script

For macOS with Homebrew:

```bash
# Install essential tools
brew install git neovim tmux ripgrep fzf bat fd exa htop gh git-delta tig

# Install cask applications
brew install --cask iterm2 visual-studio-code miniconda

# Set up fzf
$(brew --prefix)/opt/fzf/install

# Install Python tools
pip install black pytest ipython jupyter
```

For Ubuntu/Debian:

```bash
# Install essential tools
sudo apt-get update
sudo apt-get install git neovim tmux ripgrep fzf bat fd-find htop gh

# Python
sudo apt-get install python3-pip python3-venv

# Download and install Miniconda manually from:
# https://docs.conda.io/en/latest/miniconda.html
```

---

## Learn More

- **Homebrew**: https://brew.sh/
- **Oh My Zsh**: https://ohmyz.sh/
- **Neovim**: https://neovim.io/
- **tmux**: https://github.com/tmux/tmux/wiki
- **fzf**: https://github.com/junegunn/fzf
- **ripgrep**: https://github.com/BurntSushi/ripgrep
- **Modern Unix Tools**: https://github.com/ibraheemdev/modern-unix

---

**Last Updated**: 2025-11-05
