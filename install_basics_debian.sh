# a bash script which does initial setup and installs the basics on a debian system

# symlink the /root directory to /home/root
ln -s /root /home/root

# update the system and upgrade all the packages
apt update -y && apt upgrade -y

# install the locales package and zsh
apt-get install locales-all zsh

# skip the locale check by creating a file
touch /var/lib/cloud/instance/locale-check.skip

# set the locale to en_US.UTF-8
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"


# install all basic packages with apt in one single command
apt install cron git duf fzf ripgrep htop curl fail2ban php8.2 php8.2-zip php-json php8.2-cli php8.2-common php8.2-imap php8.2-redis php8.2-snmp php8.2-xml php8.2-mysql php8.2-zip php8.2-mbstring php8.2-curl libapache2-mod-php mariadb-server ufw rsync gh php exa bat lsd ranger mc python3-pip python3-venv virtualenv cargo libaugeas0 tmux fd-find php8.2-imagick php8.2-intl php8.2-gd phpmyadmin -y


# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# set the default shell to zsh
chsh -s $(which zsh)

# configure the firewall
# allow ssh, http, https, and mysql
ufw allow ssh
ufw allow http
ufw allow https
#ufw allow mysql
ufw enable

# configure fail2ban
systemctl enable fail2ban
# copy the default config file
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# start the fail2ban service
systemctl start fail2ban

# install the latest LTS version of npm
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.14.0".
nvm current # Should print "v22.14.0".

# Verify npm version:
npm -v # Should print "10.9.2".

# enable and start the apache2 and mariadb services
systemctl enable apache2 && systemctl start apache2
systemctl start mariadb && systemctl enable mariadb

# install latest wordpress version from source
#cd /var/www/html
#wget https://wordpress.org/latest.tar.gz
#tar -xvf latest.tar.gz
#rm latest.tar.gz
#chown -R www-data:www-data /var/www/html/wordpress
#chmod -R 755 /var/www/html/wordpress
#mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
#mysql -u root -p
#CREATE DATABASE wordpress;
#CREATE USER 'wordpress'@'localhost'
#IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON wordpress.*
#TO 'wordpress'@'localhost';
#FLUSH PRIVILEGES;
#exit;
#systemctl restart apache2
#systemctl restart mysql
#systemctl restart mariadb

# install wp-cli
#curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#chmod +x wp-cli.phar
#mv wp-cli.phar /usr/local/bin/wp

# install latest version of rustc for debian
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install dust using cargp
cargo install du-dust

# install fdfind using cargo
#cargo install fd-find

# install certbot using pip in a virtual environment
python3 -m venv /opt/certbot/
source /opt/certbot/bin/activate
pip install certbot
deactivate

# prepare the certbot command
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot

# install thefuck (a tool to correct your previous console command)
apt install thefuck -y
# add thefuck to the bash aliases
echo "eval $(thefuck --alias)" >> ~/.bashrc
# add thefuck to the zsh plugins
sed -i 's/plugins=(git)/plugins=(git thefuck)/g' ~/.zshrc
