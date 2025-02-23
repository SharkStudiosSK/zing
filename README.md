
# Zing

Zing is a package manager written in Go that pulls packages(zinglets) from https://github.com/SharkStudiosSK/zinglets-repo and installs them using

```
zing install <package>
```
check out https://github.com/SharkStudiosSK/zingpackage for the code that runs the package installer

## Installation
You can install Zing with one command
```
sudo curl -fsSL https://raw.githubusercontent.com/SharkStudiosSK/zing/refs/heads/main/install.sh | sh
```

### From Source
```
git clone https://github.com/SharkStudiosSK/zing.git
cd zing
go mod tidy
```
Then just build
```
go build -o zing main.go
```
And move to ~/bin(PATH)
```
mkdir -p ~/bin
mv zing ~/bin/
```

If ~/bin and ~/.zing/installed are not already in your PATH, add them by appending these lines to your ~/.bashrc (or equivalent shell configuration file):
```
mkdir -p ~/.zing/installed
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.zing/installed:$PATH"
```

And source ~/.bashrc
```
source ~/.bashrc
```
