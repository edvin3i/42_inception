## 0a. Download and create a virtual machine in VirtualBox

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads) (preinstalled on the school's machnes)
- [Download latest Debian](https://www.debian.org/distrib/)

```
I recommend following parameters for VM:
- CPU: 4C
- RAM: 8GB
- HDD: 20GB
```

Install a guest OS with any windows manager: Xfce for example.


## 0b. Install VBoxLinuxAdditions
Insert VBoxGuestAdditions.iso as a virtual drive 
```bash
sh ./VBoxLinuxAdditions.run
```

## 0c. Set the port forwarding VM <=> Host
In the network settins in VBox set port forwarding for SSH (22), HTTPS (443) etc.


## 0d. Set domain name
```bash
echo "127.0.0.1        $USER.42.fr" >> /etc/hosts
```

## 1. Install tools
1. Login into your VM and switch to the root.
2. Run the following commands.
```bash
apt update && apt install -y sudo ufw curl wget git libnss3-tools make net-tools zsh vim htop mc
```
## 2. User
1. Add your user to ```sudo``` and ```docker``` groups
```bash
usermod -aG sudo $USER
usermod -aG docker $USER
```
2. Add your user to sudoers file
```bash
visudo
username  ALL=(ALL:ALL) ALL
```

## 3. SSH
You can modify ```/etc/ssh/sshd_config``` as you want: change SSH port for example (don't forget to change Firewall and VM's port forwarding too).

## 4. Docker and Docker Compose
1. Add Docker repository
```bash
sudo apt install ca-certificates -y
sudo install -m 0755 -d /etc/apt/keyrings/
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
sudo $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
2. Installing Docker and Docker Compose
```bash
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

```
3. Test
```bash
sudo service docker start
sudo docker run hello-world
```
After the testing remove the container and image 'hello-world' (see ```rm``` and ```rmi``` commands).

## 5. Firewall
```bash
sudo ufw allow ssh          # opens default SSH     22 port
sudo ufw allow http         # opens default HTTP    80 port
sudo ufw allow https        # opens default HTTPS   443 port
sudo ufw enable
```
## Certificates
### Mkcert installation
* [Main Mkcert repo](https://github.com/FiloSottile/mkcert)

### Download pre-built binaries:
```bash
curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
```
### Set the binary as an executable and move it to the bin dir:
```bash
chmod +x mkcert-v*-linux-amd64
sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
```
### Create certificates
```bash
mkcert $USER.42.fr
```

## NGINX
### Create dirs and files
```bash
mkdir -p srcs/requirements/nginx/conf
mkdir -p srcs/requirements/nginx/tools
touch srcs/requirements/nginx/Dockerfile
touch srcs/requirements/nginx/.dockerignore
mv $USER.42.fr-key.pem srcs/requirements/nginx/tools/$USER.42.fr.key
mv $USER.42.fr.pem srcs/requirements/nginx/tools/$USER.42.fr.crt

```

## MARIA DB
### Create dirs and files
```bash
mkdir -p srcs/requirements/mariadb/conf
mkdir -p srcs/requirements/mariadb/tools
touch srcs/requirements/mariadb/Dockerfile
touch srcs/requirements/mariadb/.dockerignore
```

## WORDPRESS
### Create dirs and files
```bash
mkdir -p srcs/requirements/wordpress/conf
mkdir -p srcs/requirements/wordpress/tools
touch srcs/requirements/wordpress/Dockerfile
touch srcs/requirements/wordpress/.dockerignore
```

