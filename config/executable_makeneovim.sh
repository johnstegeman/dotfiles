cd $HOME
sudo apt remove neovim
sudo apt -y install npm
sudo apt -y update
sudo apt -y install build-essential
sudo apt-get -y install manpages-dev
sudo apt -y remove --purge --auto-remove cmake
sudo apt -y update && \
sudo apt -y install -y software-properties-common lsb-release && \
sudo apt -y clean all
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository -y "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"
sudo apt -y update
sudo apt -y install kitware-archive-keyring
sudo rm /etc/apt/trusted.gpg.d/kitware.gpg
sudo apt-key -y adv --keyserver keyserver.ubuntu.com --recv-keys 6AF7F09730B3F0A4
sudo apt -y update
sudo apt -y install cmake
sudo apt-get -y install ninja-build gettext libtool-bin cmake g++ pkg-config unzip curl
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make install
nvim --headless +q
rm -rf neovim