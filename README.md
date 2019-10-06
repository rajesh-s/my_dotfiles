# workspace
Contains settings and preferences for *NIX workspaces

clone using git clone --recursive https://github.com/rajesh-s/my_dotfiles.git

Use tarball of copy_to_home in case git access is unavailable

After copying required fonts to ~/.fonts, install the fonts using:

cd ~/.fonts
mkfontscale
mkfontdir
fc-cache -fv ~/.fonts
fc-list # The new font should now be available
