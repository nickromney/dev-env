#!/usr/bin/env ruby

################################################################################
############# Some helper variables/functions for the Vagrantfile ##############
################################################################################

# The install script for ansible on Centos 7
$centos7_ansible_install = <<-SHELL
  yum install -y epel-release
  yum install -y ansible
SHELL

# The install script for ansible on Ubuntu 16.04 (Xenial)
$xenial64_ansible_install = <<-SHELL
  apt-add-repository ppa:ansible:ansible
  apt -y update
  apt -y install ansible
SHELL

# The install script for ansible on Ubuntu 18.04 (Bionic)
$bionic64_ansible_install = <<-SHELL
  apt-add-repository ppa:ansible:ansible
  apt -y update
  apt -y install ansible
SHELL

# The install script for ansible on Ubuntu 20.04 (Focal)
# Incorporating https://stackoverflow.com/questions/46045192/how-to-automatically-install-ansible-galaxy-roles-using-vagrant
$focal64_ansible_install = <<-SHELL
  mkdir -p ~/.ssh
  mkdir -p ~/.ansible
  mkdir /etc/ansible/roles -p
  chmod o+w /etc/ansible/roles
  apt-get -y update
  apt-get -y install python3-pip
  pip3 install Jinja2==2.11.2
  pip3 install ansible
SHELL

# The install script for ansible on Arch Linux
$archlinux_ansible_install = <<-SHELL
  pacman -Syyu --noconfirm
  pacman -S ansible --noconfirm
SHELL

# Gets the $X_ansible_install variable that holds a shell script to install
#   ansible, depending on BOX_NAME
def get_ansible_install(boxname)
  case boxname
  when "centos/7"
    $centos7_ansible_install
  when "ubuntu/xenial64"
    $xenial64_ansible_install
  when "ubuntu/bionic64"
    $bionic64_ansible_install
  when "ubuntu/focal64"
    $focal64_ansible_install
  when "archlinux/archlinux"
    $archlinux_ansible_install
  end
end

# Gets the name of the ansible role to use based on the BOX_NAME
def get_ansible_role(boxname)
  case boxname
  when "centos/7"
    "centos7"
  when "ubuntu/xenial64"
    "xenial64"
  when "ubuntu/bionic64"
    "bionic64"
  when "ubuntu/focal64"
    "focal64"
  when "archlinux/archlinux"
    "arch"
  end
end

# Gets the directory to use for the --with-python3-dir parameter when running
#   ./configure for vim
def get_vim_python3_dir(boxname)
  case boxname
  when "centos/7"
    "/lib64/python3/config"
  when "ubuntu/xenial64"
    "/usr/lib/python3/config"
  when "ubuntu/bionic64"
    "/usr/lib/python3/config"
  when "ubuntu/focal64"
    "/usr/lib/python3/config"
  when "archlinux/archlinux"
    "/usr/lib/python3/config"
  end
end
