#!/bin/bash
#
# QDeptartment's macos fresh-install script
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

TAPS=(
    heroku/brew
)
echo "Tapping formulae..."
brew tap ${TAPS[@]}

PACKAGES=(
    ffmpeg
    git
    nodejs
    wget
    neofetch
    python
    python3
    cmake
    mas
    awscli
    go
    rust
    heroku
    gti
    jq
    nvm
    hugo
    netcdf
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
    google-earth-pro
    slack
    vlc
    vox
    spotify
    sublime-text
    visual-studio-code
    sourcetree
    fork
    anaconda
    sequel-pro
    carbon-copy-cloner
    ltspice
    inkscape
    omnigraffle
    blender
    arduino
    unity-hub
    discord
    find-any-file
    ilok-license-manager
    keka
    pd
    plex
    processing
    skype
    steam
    transmission
    transmit
    reaper
    cycling74-max
    loopback
    audio-hijack
    licecap
    adobe-creative-cloud
    waves-central
    native-access
    ableton-live-suite
    soundtoys
    iem-plugin-suite
    teamviewer
    anydesk
    nordvpn
)
echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Installing Python packages..."

PYTHON_PACKAGES=(
    mutagen
    boto3
    jwt
    matplotlib
    serverless
    chalice
    liz
    librosa
    numpy
    scipy
)
sudo pip3 install ${PYTHON_PACKAGES[@]}
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Installing node packages (npm)"
NPM_PACKAGES=(
    bower
    grunt-cli
    )
npm install -g ${NPM_PACKAGES[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    cocoapods
    bundler
    jekyll
)
sudo gem install ${RUBY_GEMS[@]}

echo "Install Mac App Store (mas)..."
APPS=(
	441258766
	409183694
	408981434
	1274495053
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
	1450874784
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
# 497799835 Xcode
# 1450874784 Transporter (macos dev)

echo "Configuring OSX..."

# Show filename extensions by default
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Show volumes on desktop
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
#defaults write com.apple.finder ShowRemovableMediasOnDesktop -bool true
#defaults write com.apple.finder ShowMountedServersOnDesktop -bol true

echo "MacOS Setup complete"

echo "Setting up locahost https (https-server)"
cd ~/
mkdir .localhost-ssl
sudo openssl genrsa -out ~/.localhost-ssl/localhost.key 2048
sudo openssl req -new -x509 -key ~/.localhost-ssl/localhost.key -out ~/.localhost-ssl/localhost.crt -days 3650 -subj /CN=localhost
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.localhost-ssl/localhost.crt
npm install -g http-server
echo " 
function https-server() {
  http-server --ssl --cert ~/.localhost-ssl/localhost.crt --key ~/.localhost-ssl/localhost.key
}
" >> ~/.zshrc
echo "You're ready to use https on localhost 💅"

echo " 
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH
" >> ~/.zshrc
source ~/.bash_profile
source ~/.zshrc

echo "Please use Disk Utility to create the /Volumes/git project workspace"
echo "Change your ~/.zshrc theme to ys"

