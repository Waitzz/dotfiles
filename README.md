# dotfiles

A minimal and efficient dotfiles management repository powered by **Mise** and **Dotter**.

## 🛠️ Features

- **Mise**: Automatically installs and manages development tools, languages, and environments.
- **Dotter**: Templating and symlink deployment for dotfiles configuration modules.

## 🚀 Installation

To initialize your environment and deploy the configurations, run the installation script:

```bash
./install.sh
```

The script will:
1. Install **Mise** if it is not already installed.
2. Install all CLI tools declared in `.mise.toml`.
3. Invoke **Dotter** to automatically deploy and symlink configuration files.

## 🧹 Uninstallation

To safely revert symlinks, purge the configurations, and remove Mise-installed tools:

```bash
./uninstall.sh
```
