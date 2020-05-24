#!/bin/bash
#
# My personal fresh-install script
#
# DUNGEON OF MANUAL SHAME:
# (list of apps not handled by package manager and require manual installing)
# - 
#

echo "Start installing brew dependencies..."

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Install zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions
source ~/.zshrc

PACKAGES=(
    ffmpeg
    git
    npm
    python
    pip
    python3
    pip3
    wget
    neofetch
    cmake
    mas
    awscli
    go
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
CASKS=(
    dropbox
    firefox
    google-chrome
    slack
    vlc
    spotify
    sublime-text
    visual-studio-code
    sourcetree
    anaconda
    sequel-pro
    ltspice
    inkscape
    reaper
    arduino
    unity-hub
    discord
    find-any-file
    ilok-license-manager
    keka
    librecad
    pacifist
    pd
    plex
    processing
    skype
    steam
    transmission
    transmit
    cycling74-max
    skype
    loopback
    audio-hijack
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing Python packages..."
PYTHON_PACKAGES=(
	mutagen
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "Install Mac App Store (mas)..."

APPS=(
	441258766 
	409183694 
	408981434 
	1274495053
	461369673 
	443987910  
	404167677
	904280696
	409201541
	409203825
	1458220908
	1445242832
	937984704
	634148309
	497799835
)
mas install ${APPS[@]}

# APP LIST: 
# 441258766 Magnet
# 409183694 Keynote
# 408981434 iMovie
# 1274495053 Microsoft To Do
# 461369673 VOX
# 443987910 1Password 
# 404167677 IP Scanner Pro 
# 904280696 Things 
# 409201541 Pages 
# 409203825 Numbers
# 1458220908 Markdown Editor
# 937984704 Amphetamine
# 634148309 Logic Pro X
# 1445242832 Storyist
# 497799835 Xcode

echo "Configuring OSX..."

# Show filename extensions by default
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "MacOS Setup complete"

echo "Do you want to create your ~/.ssh/personal-ssh-key SSH key?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
            echo "Initializing SSH..."
            ssh-keygen -t rsa -b 4096 -C "dylan@dylanjmarcus.com"
            eval "$(ssh-agent -s)"
            touch ~/.ssh/config
            ssh-add -K ~/.ssh/personal-ssh-key
            echo "Please copy and paste ssh key into github accounts as needed"
            break;;
        No ) break;;
    esac
done

echo "Please use Disk Utility to create the /Volumes/git project workspace"
echo "Change your ~/.zshrc theme to ys"