#!/bin/bash

set -e

# Get the repository URL (replace with your actual Zing source code repo URL)
REPO_URL="https://github.com/SharkStudiosSK/zing.git" # CHANGE THIS TO YOUR NEW REPO

# Go version requirement
GO_VERSION_REQUIRED="1.18"

# Check if Go is installed
if ! command -v go >/dev/null 2>&1; then
    echo "Error: Go is not installed. Please install Go ${GO_VERSION_REQUIRED} or later."
    exit 1
fi

# Get Go version and compare
go_version=$(go version | awk '{print $3}' | sed 's/^go//')
if ! echo "$go_version" | grep -qE '^[0-9]+\.[0-9]+'; then
    echo "Error: Could not parse Go version from 'go version' output."
    exit 1
fi

# Function to compare version numbers
version_ge() {
    [ "$(printf '%s\n%s' "$1" "$2" | sort -V | head -n1)" = "$2" ]
}

if ! version_ge "$go_version" "$GO_VERSION_REQUIRED"; then
    echo "Error: Your Go version ($go_version) is too old. Please install Go ${GO_VERSION_REQUIRED} or later."
    exit 1
fi

# Check if Git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Error: Git is not installed. Please install Git."
    exit 1
fi

# Clone the repository
git clone "$REPO_URL" zing-temp

# Change directory into the cloned repository
cd zing-temp

# Update zingpackage
go mod tidy

# Build the main.go file with output named 'zing'
go build -o zing main.go

# Check if the build was successful
if [[ ! -f ./zing ]]; then
    echo "Error: Build failed. The 'zing' executable was not found."
    exit 1
fi

# Create bin directory in user's home if it doesn't exist
mkdir -p ~/bin

# Move the executable to ~/bin
mv ./zing ~/bin/

# Check if moving was successful
if [[ ! -f ~/bin/zing ]]; then
    echo "Error: Failed to move 'zing' to ~/bin. Check permissions."
    exit 1
fi

# Check if ~/bin is in PATH, add it if not
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    echo "~/bin has been added to your PATH. Please run 'source ~/.bashrc' or restart your terminal to apply changes."
else
    echo "~/bin is already in your PATH."
fi

# Cleanup (remove the cloned repository)
cd ..
rm -rf zing-temp

echo "Zing has been successfully installed. You can now use the 'zing' command after applying the PATH changes."
exit 0
