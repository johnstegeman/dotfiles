# Bootstrap a fresh machine
bootstrap: brew mise

# Install/update Homebrew packages from Brewfile
brew:
    brew bundle --file=config/Brewfile

# Install/update mise-managed runtimes
mise:
    mise install

# Apply chezmoi dotfiles
apply:
    chezmoi apply

# Update everything
update: brew mise apply
