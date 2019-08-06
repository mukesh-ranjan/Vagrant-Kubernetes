sudo update-ca-certificates

echo "Disabling ssl for git"
git config --global http.sslVerify false

echo "Cloning"
git clone https://github.com/mukesh-ranjan/Vagrant-Kubernetes

echo "Initializing LXD Please enter your choice"
lxd init

echo "Configuring LXD"

echo "================================================="
echo "Step1: configuring set core.https_address"
sudo lxc config set core.https_address [::]:8443

echo "Step2: configuring set core.https_allowed_origin"
sudo lxc config set core.https_allowed_origin "*"

echo "Step2: configuring set core.https_allowed_methods"
sudo lxc config set core.https_allowed_methods "GET, POST, PUT, DELETE, OPTIONS"

echo  "Allowing content-type"
sudo lxc config set core.https_allowed_headers "Content-Type"

echo "Restarting Lxd"
sudo service lxd restart

echo "====================LXD Configuration End============================="

echo "================================================="

echo "Setting up of Authentication Certificate (Self Signed)"

echo "mkdir lxd-api-access-cert-key-files"
mkdir lxd-api-access-cert-key-files
echo  "cd lxd-api-access-cert-key-files"

cd lxd-api-access-cert-key-files

echo "Setting up openssl"

openssl genrsa -out lxd-webui.key 4096

echo "Enter the requested details"

openssl req -new -key lxd-webui.key -out lxd-webui.csr

openssl x509 -req -days 3650 -in lxd-webui.csr -signkey lxd-webui.key -out lxd-webui.crt

sudo update-ca-certificates

lxc config trust add lxd-webui.crt

echo "====================Certificate Generation Steps End============================="

cd -


echo "=================INSTALLING ANSIBLE================================"

echo "Ansible Pre-requisit"
echo "sudo apt-get update "
sudo apt-get update 

echo "sudo apt-get install -y software-properties-common "
sudo apt-get install -y software-properties-common 

echo "sudo mkdir -p /etc/apt/sources.list.d"
sudo mkdir -p /etc/apt/sources.list.d

echo "# Adde the Ansible sources."
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu wily main" | sudo tee -a /etc/apt/sources.list.d/ansible.list
echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu wily main" | sudo tee -a /etc/apt/sources.list.d/ansible.list


echo "Now Ansible Installation started "
sudo apt-get update
sudo apt-get install ansible 

echo "====================ANSIBLE INSTALLATION ENDS============================="


echo "=================LXC CONTAINER CREATEION STEP================================"

cd lxc-kubernetes

ansible-playbook playbook.yml


