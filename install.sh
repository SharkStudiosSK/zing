#!/bin/bash

set -e

# Get the repository URL (replace with your actual Zing source code repo URL)
REPO_URL="https://github.com/SharkStudiosSK/zing.git" # CHANGE THIS TO YOUR NEW REPO

# Go version requirement
GO_VERSION_REQUIRED="1.18"

# Check if Go is installed and the version is sufficient
#if ! /opt/go/bin/go version &> /dev/null; then
#  echo "Error: Go is not installed. Please install Go ${GO_VERSION_REQUIRED} or later."
#  exit 1
#fi

go_version=$(go version | awk '{print $3}' | sed 's/^go//')
if [[ "$(printf '%s\n%s' "$GO_VERSION_REQUIRED" "$go_version" | sort -V | head -n1)" == "$GO_VERSION_REQUIRED" ]]; then
    echo "Error: Your Go version ($go_version) is too old. Please install Go ${GO_VERSION_REQUIRED} or later."
    exit 1
fi

# Check if Git is installed
if ! command -v git &> /dev/null; then
  echo "Error: Git is not installed. Please install Git."
  exit 1
fi

# Clone the repository
git clone "$REPO_URL" zing-temp

# Change directory into the cloned repository
cd zing-temp

# Build the main.go file
go build main.go

# Check if the build was successful
if ! [[ -f ./zing ]]; then
    echo "Error. Build failed. The 'zing' executable was not found."
    exit 1
fi

# Move the executable to /usr/local/bin (requires sudo)
sudo mv ./zing /usr/local/bin/

# Check if moving was successful
if [[ ! -f /usr/local/bin/zing ]]; then
    echo "Error: Failed to move 'zing' to /usr/local/bin. Check permissions."
    exit 1
fi

# Cleanup (remove the cloned repository)
cd ..
rm -rf zing-temp

echo "Zing has been successfully installed. You can now use the 'zing' command."
exit 0
