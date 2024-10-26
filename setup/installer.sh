#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
REPO_URL="https://github.com/dana-research-group/dana-research-dotfiles.git"  # Replace with your actual repo URL
CONFIG_DIR="$HOME/.bash_config"
SHARED_DIR="$CONFIG_DIR/shared"
SERVERS_DIR="$CONFIG_DIR/servers"
TEMPLATES_DIR="$CONFIG_DIR/templates"
USER=$(whoami)
HOSTNAME=$(hostname)
BASHRC="$HOME/.bashrc"
BASH_ALIASES="$HOME/.bash_aliases"
BACKUP_BASHRC="$HOME/.bashrc.backup.$(date +%F_%T)"
BACKUP_BASH_ALIASES="$HOME/.bash_aliases.backup.$(date +%F_%T)"
LOG_FILE="$CONFIG_DIR/setup.log"

# Function to display messages
echo_info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

echo_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1" >&2
}

# Create configuration directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Initialize logging
exec > >(tee -a "$LOG_FILE") 2>&1

echo_info "Starting Bash configuration setup..."
echo_info "User: $USER"
echo_info "Host: $HOSTNAME"
echo_info "Configuration directory: $CONFIG_DIR"

# Clone the repository if it doesn't exist
if [ ! -d "$CONFIG_DIR/.git" ]; then
    echo_info "Cloning configuration repository into $CONFIG_DIR"
    git clone "$REPO_URL" "$CONFIG_DIR"
else
    echo_info "Configuration repository already exists. Pulling latest changes."
    cd "$CONFIG_DIR" && git pull origin main
fi

# Determine which configuration file to use based on hostname
if [[ "$HOSTNAME" == "tech-ui02.hep.technion.ac.il" ]]; then
    CONFIG_FILE="$BASH_ALIASES"
    SERVER_CONFIG_FILE="$SERVERS_DIR/atlas.sh"
elif [[ "$HOSTNAME" == "zeus.technion.ac.il" ]]; then
    CONFIG_FILE="$BASHRC"
    SERVER_CONFIG_FILE="$SERVERS_DIR/zeus.sh"
else
    echo_error "Unsupported hostname: $HOSTNAME. Exiting."
    exit 1
fi

# Backup existing configuration files
if [ "$CONFIG_FILE" == "$BASHRC" ]; then
    if [ ! -f "$BACKUP_BASHRC" ]; then
        echo_info "Backing up your current .bashrc to $BACKUP_BASHRC"
        cp "$BASHRC" "$BACKUP_BASHRC"
    else
        echo_info "Backup of .bashrc already exists at $BACKUP_BASHRC"
    fi
elif [ "$CONFIG_FILE" == "$BASH_ALIASES" ]; then
    if [ ! -f "$BACKUP_BASH_ALIASES" ]; then
        echo_info "Backing up your current .bash_aliases to $BACKUP_BASH_ALIASES"
        cp "$BASH_ALIASES" "$BACKUP_BASH_ALIASES"
    else
        echo_info "Backup of .bash_aliases already exists at $BACKUP_BASH_ALIASES"
    fi
fi

# Remove existing source block to prevent duplication
SOURCE_BLOCK_START="# >>> Dana Research Group Bash Configurations >>>"
SOURCE_BLOCK_END="# <<< End of Dana Research Group Bash Configurations <<<"
sed -i "/$SOURCE_BLOCK_START/,/$SOURCE_BLOCK_END/d" "$CONFIG_FILE"

# Add new source block to the appropriate configuration file
{
    echo ""
    echo "$SOURCE_BLOCK_START"
    echo "export CONFIG_DIR=\"$CONFIG_DIR\""
    echo "export SHARED_DIR=\"$SHARED_DIR\""
    echo "export HOSTNAME=\"$HOSTNAME\""
    echo "export USER=\"$USER\""
    echo ""
    echo "if [ -d \"\$SHARED_DIR\" ]; then"
    echo "    for file in \"\$SHARED_DIR\"/*.sh; do"
    echo "        source \"\$file\""
    echo "    done"
    echo "fi"
    echo ""
    echo "if [ -f \"$SERVER_CONFIG_FILE\" ]; then"
    echo "    source \"$SERVER_CONFIG_FILE\""
    echo "fi"
    echo ""
    echo "$SOURCE_BLOCK_END"
} >> "$CONFIG_FILE"

echo_info "Updated $CONFIG_FILE with Dana Research Group configurations."

# Source the updated configuration file
echo_info "Sourcing the updated $CONFIG_FILE"
if [ "$CONFIG_FILE" == "$BASHRC" ]; then
    source "$BASHRC"
elif [ "$CONFIG_FILE" == "$BASH_ALIASES" ]; then
    source "$BASH_ALIASES"
fi

echo_info "Installation complete. Please restart your terminal or run 'source $CONFIG_FILE' to apply changes."
