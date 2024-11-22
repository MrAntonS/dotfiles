#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt the user
prompt_user() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0 ;;
        n|N ) return 1 ;;
        * ) echo "Please enter y or n."; prompt_user "$1" ;;
    esac
}

# Update package manager and install dependencies
install_dependencies() {
    echo "Installing $1..."
    if command_exists apt; then
        sudo apt update && sudo apt install -y "$1"
    elif command_exists yum; then
        sudo yum install -y "$1"
    elif command_exists dnf; then
        sudo dnf install -y "$1"
    elif command_exists pacman; then
        sudo pacman -Sy --noconfirm "$1"
    elif command_exists brew; then
        brew update && brew install "$1"
    else
        echo "Unsupported package manager. Please install $1 manually."
        exit 1
    fi
}

# Main installation logic
install_tool() {
    local tool_name=$1
    if ! command_exists "$tool_name"; then
        if prompt_user "$tool_name is not installed. Do you want to install it?"; then
            install_dependencies "$tool_name"
        else
            echo "Skipping $tool_name installation."
        fi
    else
        echo "$tool_name is already installed: $($tool_name --version 2>/dev/null || echo "No version info available.")"
    fi
}

# Check if Homebrew is installed on macOS
setup_homebrew() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command_exists brew; then
            if prompt_user "Homebrew is not installed. Do you want to install it?"; then
                echo "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                echo "Homebrew installed successfully."
            else
                echo "Homebrew is required to install packages on macOS. Exiting."
                exit 1
            fi
        fi
    fi
}

# Main process
if [[ "$OSTYPE" == "darwin"* ]]; then
    setup_homebrew
fi

install_tool "python3"
install_tool "unzip"
echo "Installation process completed!"
