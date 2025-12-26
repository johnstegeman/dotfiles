# Configuration Review & Recommendations

Based on a review of your current dotfiles configuration and research into modern utilities, here are recommendations for enhancements.

## 🎯 High-Value Additions

### 1. **lazygit** - Git TUI
**Status**: Commented out in Brewfile  
**Why**: Excellent terminal UI for git operations, complements your CLI workflow  
**Action**: Uncomment `brew "lazygit"` in Brewfile

```bash
# Already in Brewfile, just uncomment:
brew "lazygit"
```

### 2. **direnv** - Project-Specific Environment Variables
**Status**: Referenced in starship but not configured  
**Why**: Automatically load/unload environment variables based on directory  
**Action**: Add to Brewfile and configure

```bash
# Add to Brewfile
brew "direnv"

# Add to fish config.fish (after zoxide init)
if using direnv
    direnv hook fish | source
end
```

### 3. **btop** - Modern System Monitor
**Status**: You have `bottom` installed  
**Why**: Alternative modern monitor with different UI/features  
**Action**: Consider adding as alternative

```bash
brew "btop"
```

### 4. **gum** - Interactive Shell Scripts
**Status**: Not installed  
**Why**: Beautiful interactive prompts for shell scripts from charm.sh  
**Action**: Add to Brewfile

```bash
brew "gum"
```

### 5. **just** - Command Runner
**Status**: Not installed  
**Why**: Modern alternative to `make` for running project commands  
**Action**: Add to Brewfile

```bash
brew "just"
```

### 6. **tldr** - Simplified Man Pages
**Status**: Not installed  
**Why**: Quick, practical examples instead of full man pages  
**Action**: Add to Brewfile

```bash
brew "tldr"
```

### 7. **procs** - Modern `ps` Replacement
**Status**: Not installed  
**Why**: Better `ps` with colors and tree view  
**Action**: Add to Brewfile

```bash
brew "procs"
```

## 🌟 Starship Prompt Enhancements

Your starship config is good, but consider adding these modules:

### Docker Module
```toml
[docker_context]
symbol = "🐳 "
style = "blue bold"
format = "via [$symbol$context]($style) "
disabled = false
```

### Kubernetes Module
```toml
[kubernetes]
symbol = "☸ "
style = "blue bold"
format = "via [$symbol$context]($style) "
disabled = false
```

### Nix Shell Module
```toml
[nix_shell]
symbol = "❄️ "
style = "blue bold"
format = "via [$symbol$state]($style) "
disabled = false
```

### Time Module
```toml
[time]
disabled = false
format = "🕙 [$time]($style) "
style = "bold yellow"
```

### Memory Usage Module
```toml
[memory_usage]
disabled = false
threshold = 75
symbol = " "
style = "bold dimmed red"
```

## 🐟 Fish Shell Plugin Recommendations

### Additional Useful Plugins

1. **jorgebucaran/nvm.fish** - Node version management
   ```bash
   fisher install jorgebucaran/nvm.fish
   ```

2. **jorgebucaran/getopts.fish** - Command-line option parser
   ```bash
   fisher install jorgebucaran/getopts.fish
   ```

3. **jorgebucaran/replay.fish** - Replay shell commands
   ```bash
   fisher install jorgebucaran/replay.fish
   ```

4. **gazorby/fish-exa** - Better exa/eza integration (if you want more features)
   ```bash
   fisher install gazorby/fish-exa
   ```

## 🔧 Utility Enhancements

### 1. **ripgrep-all** - Search in more file types
```bash
brew "ripgrep-all"
```

### 2. **difftastic** - Better diff tool (alternative/complement to delta)
```bash
brew "difftastic"
```

### 3. **dust** - More intuitive `du` alternative
```bash
brew "dust"
```

### 4. **hyperfine** - Command-line benchmarking
```bash
brew "hyperfine"
```

### 5. **mcfly** - Alternative to atuin (if you want to try something different)
```bash
brew "mcfly"
```

## 📝 Configuration Improvements

### 1. **Fix `enable_transience` Function**
**Issue**: Called but not defined in fish config  
**Fix**: Either remove the call or create the function:

```fish
# Option 1: Remove the call (if not needed)
# enable_transience

# Option 2: Create the function (if using starship transient prompts)
function enable_transience
    starship config set transient true
end
```

### 2. **Add direnv Configuration**
Create `~/.config/direnv/direnvrc` or add to fish config:

```fish
# In config.fish, after direnv hook
if using direnv
    set -gx DIRENV_LOG_FORMAT ""
end
```

### 3. **Enhance Git Delta Configuration**
Consider adding more delta features in `~/.config/git/config`:

```ini
[delta]
features = "decorations side-by-side line-numbers"
line-numbers = true
line-numbers-left-format = "{nm:>4} │ "
line-numbers-right-format = "{np:>4} │ "
```

### 4. **Add Fish Abbreviations**
Consider adding more useful abbreviations:

```fish
abbr -a -- gco 'git checkout'
abbr -a -- gcb 'git checkout -b'
abbr -a -- gd 'git diff'
abbr -a -- gds 'git diff --staged'
abbr -a -- glog 'git log --oneline --graph --decorate'
abbr -a -- ll 'ls -la'
abbr -a -- la 'ls -A'
```

## 🎨 Theme Consistency

### 1. **Ghostty Rose Pine Colors**
Consider updating `~/.config/ghostty/config` with Rose Pine colors:

```ini
# Rose Pine Main colors
palette = 0=#191724
palette = 1=#eb6f92
palette = 2=#9ccfd8
palette = 3=#f6c177
palette = 4=#31748f
palette = 5=#c4a7e7
palette = 6=#ebbcba
palette = 7=#e0def4
palette = 8=#6e6a86
palette = 9=#eb6f92
palette = 10=#9ccfd8
palette = 11=#f6c177
palette = 12=#31748f
palette = 13=#c4a7e7
palette = 14=#ebbcba
palette = 15=#e0def4
background = #191724
foreground = #e0def4
cursor-color = #e0def4
```

## 🚀 Productivity Tools

### 1. **navi** - Interactive cheatsheet tool
```bash
brew "navi"
```

### 2. **choose** - Better `cut` alternative
```bash
brew "choose"
```

### 3. **sd** - Intuitive find & replace
```bash
brew "sd"
```

### 4. **xsv** - Fast CSV command-line toolkit
```bash
brew "xsv"
```

### 5. **zellij** - Already installed, but consider configuration
You have zellij installed. Consider creating a config file for it.

## 📊 Monitoring & System Tools

### 1. **bandwhich** - Network utilization by process
```bash
brew "bandwhich"
```

### 2. **dog** - Better `dig` alternative
```bash
brew "dog"
```

### 3. **yt-dlp** - YouTube downloader (if you need it)
```bash
brew "yt-dlp"
```

## 🔐 Security & Privacy

### 1. **age** - Simple file encryption
```bash
brew "age"
```

### 2. **gopass** - Password manager CLI (if not using 1Password CLI)
```bash
brew "gopass"
```

## 🎯 Quick Wins (Easy to Add)

1. **Uncomment lazygit** in Brewfile
2. **Add direnv** for project environments
3. **Add tldr** for quick help
4. **Add gum** for better scripts
5. **Fix enable_transience** function
6. **Add more starship modules** (docker, kubernetes, time)

## 📚 Learning Resources

- [Awesome Fish Shell](https://github.com/jorgebucaran/awesome-fish)
- [Starship Modules](https://starship.rs/config/)
- [Modern Unix Tools](https://github.com/ibraheemdev/modern-unix)

## 🎨 Rosé Pine Theme Resources

- [Rosé Pine Website](https://rosepinetheme.com/)
- [Rosé Pine GitHub](https://github.com/rose-pine)

---

**Note**: Not all recommendations need to be implemented. Choose based on your workflow and needs. Start with the "Quick Wins" section for immediate improvements.

