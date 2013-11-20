#! /bin/bash

wget -qO- https://get.docker.io/gpg | apt-key add -

echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# Add the Docker repository to your apt sources list.
echo "deb http://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
apt-get -y install python-software-properties
# Repository pour oracle-jdk
add-apt-repository -y ppa:webupd8team/java
apt-get update && apt-get -y upgrade

echo "--------------------------------------------------------------------"
echo "Installation de git"
echo "Installation de docker"
echo "Installation de keymon (keyboard and mouse monitor for screencasts)"
echo "Installation de shutter (Utilitaire de capture d'écran)"
echo "Installation de remmina (Bureau à distance multi-service : VNC, RDP, etc)"
apt-get -y install git lxc-docker keymon shutter remmina

echo "--------------------------------------------------------------------"
echo "Installation de Sublime Text 3"
cd /tmp && wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3047_amd64.deb && dpkg -i sublime-text_build-3047_amd64.deb && rm sublime-text_build-3047_amd64.deb && cd ~/

echo "--------------------------------------------------------------------"
# automatically accept oracle license
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
# and install java 7 oracle jdk
apt-get -y install wget oracle-java7-installer && apt-get clean
update-alternatives --display java
echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment
echo "Installation du JDK 7 Oracle"

echo "--------------------------------------------------------------------"
cd ~/ && wget http://stedolan.github.io/jq/download/linux64/jq
chmod +x ./jq
mv jq /usr/bin
echo "Installation de jq (JSon cli parser)"

echo "--------------------------------------------------------------------"
echo "Configuration..."
git config --global user.name "nicogiard"
git config --global user.email "nicogiard@gmail.com"

touch /home/nicogiard/.bash_aliases
sh -c "echo alias did=\'docker ps -l -q\' >> /home/nicogiard/.bash_aliases"
sh -c "echo alias dip=\'docker inspect `did` \| jq -r \".[0].NetworkSettings.IPAddress\"\' >> /home/nicogiard/.bash_aliases"

echo "--------------------------------------------------------------------"
notify-send -i "terminal" "Ubuntu Init Script" "Fin de l'installation"
echo "Tout est prêt. A toi de jouer maintenant"
