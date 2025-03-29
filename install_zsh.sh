apt install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# set the default shell to zsh
chsh -s $(which zsh)

# install dust using cargp
cargo install du-dust

# install fdfind using cargo
cargo install fd-find
