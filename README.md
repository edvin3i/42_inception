### 1. Download and install a virtual machine in VirtualBox
'[Download VirualBox](https://www.virtualbox.org/wiki/Downloads)'
'[Download latest Debian](https://www.debian.org/distrib/)'
Install a guest OS with any windows manager.

### Install tools and docker
'''
apt update && apt install -y sudo ufw curl wget git libnss3-tools docker docker-compose make zsh vim
'''

### Change hostname
'1. Open '/etc/hosts' '
'2. Change 'localhost' to 'yourintralogin.42.fr' '
'3. Save and exit'

### . Install VBoxLinuxAdditions
'''
root@vmachne~#: ./VBoxLinuxAdditions.run
'''

### . mkcert installation
Main mkcert repo: https://github.com/FiloSottile/mkcert

## Download pre-built binaries:
'''
curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
'''
## Set the binary as an executable and move it to the bin dir:
'''
chmod +x mkcert-v*-linux-amd64
sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
'''




