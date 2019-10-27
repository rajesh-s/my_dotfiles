#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
# Install bat.sh
curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
| grep "browser_download_url.*bat_.*amd64.deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
sudo dpkg -i bat_*amd64.deb
## Install diff-so-fancy
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
mv diff-so-fancy /usr/local/bin
### Configure git to use diff-so-fancy for all diff output:
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
## Install Exa
curl -s https://api.github.com/repos/ogham/exa/releases/latest \
| grep "browser_download_url.*linux.*zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
sudo apt install rustc
unzip exa-linux-x86_64*.zip
sudo mv exa-linux-x86_64 /usr/local/bin/exa
## Install fd
curl -s https://api.github.com/repos/sharkdp/fd/releases/latest \
| grep "browser_download_url.*fd_.*amd64.deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
sudo dpkg -i fd_*_amd64.deb
echo "All set!"
