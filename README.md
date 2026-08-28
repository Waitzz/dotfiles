# dotfiles

A modern, minimal, and efficient dotfiles management repository powered by **[Mise](https://mise.jdx.dev/)**.

## 🛠️ Features

- **Unified Toolchain**: Automatic tool installation, runtime version management, and updates powered by **Mise**.
- **Native Symlinking**: Seamless dotfiles deployment via Mise's built-in `[dotfiles]` management.
- **Enhanced Shell**: History prefix search, shell completions bridge (Mise, Pixi, Homebrew), and **x-cmd** integration.
- **Developer Workflow**: Modern terminal setup featuring Tmux, Gitmux, Delta diffs, and automated Neovim deployment.

## 🚀 Installation

Clone the repository and run the setup script:

```bash
git clone https://github.com/Waitzz/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
1. Install **Mise** (if not already installed).
2. Install all CLI tools and runtimes declared in `mise.toml`.
3. Deploy and symlink all dotfile configurations automatically.
4. Set up shell completions, initialize **x-cmd**, and clone the Neovim configuration.

## 💡 Useful Commands

- **Update all tools**:
  ```bash
  mise upgrade
  ```
- **Reapply dotfile symlinks**:
  ```bash
  mise bootstrap dotfiles apply --yes --force
  ```

## 🧹 Uninstallation

To safely revert symlinks, remove the Neovim configuration, uninstall x-cmd, and purge all tools installed by Mise:

```bash
./uninstall.sh
```
