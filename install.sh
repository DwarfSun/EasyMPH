#!/bin/bash
# Make sure only root can run the script
if [ $EUID -ne 0 ]
then
   echo "This script must be run as root. On Ubuntu, try: sudo ./install.sh UserName WorkerID" 1>&2
   exit 1
fi

if [ $# -lt 2 ]
then
  echo "Expecting username and worker ID. On Ubuntu,: try sudo ./install.sh UserName WorkerID" 1>&2
  exit 1
fi

#echo "sleeping..."
#sleep 60

apt-get --assume-yes install git automake autotools-dev build-essential cmake libcurl4-openssl-dev libhwloc-dev libjansson-dev libssl-dev libuv1-dev nvidia-cuda-dev nvidia-cuda-toolkit gcc-5 g++-5 libmicrohttpd-dev screen

mkdir -p /miners/source
cd /miners/source

#Clone EasyMPH files from GitHub
git clone https://github.com/DwarfSun/EasyMPH.git
cd EasyMPH;git pull;cd ..;

#Clone CCMiner source from GitHub
git clone https://github.com/tpruvot/ccminer.git
cd ccminer; git pull; cd ..;

#Clone xmr-stak source from GitHub
git clone https://github.com/fireice-uk/xmr-stak.git
cd xmr-stak; git pull; cd ..;

#Clone xmrig source from GitHub
git clone https://github.com/xmrig/xmrig.git
cd xmrig; git pull; cd ..;

#Build CCMiner
mkdir -p /miners/source/ccminer
cd /miners/source/ccminer
./build.sh

#Build xmr-stak
mkdir -p /miners/source/xmr-stak/build
cd /miners/source/xmr-stak/build
cmake -DCUDA_HOST_COMPILER=/usr/bin/gcc-5 ..
make

#Build xmrig
mkdir -p /miners/source/xmrig/build
cd /miners/source/xmrig/build
cmake ..
make

#Create directories for miner binaries
mkdir -p /miners/ccminer
mkdir -p /miners/xmr-stak
mkdir -p /miners/xmrig
mkdir -p /miners/zm
mkdir -p /miners/ethdcrminer

#Attempt to kill any automine screens in case user is updating EasyMPH while it's running
sudo screen -S automine -X quit
killall ccminer; killall zm; killall xmr-stak; killall ethdcrminer64;

#Move files
#CCMiner
mv /miners/source/ccminer/ccminer /miners/ccminer

#xmr-stak
mv /miners/source/xmr-stak/build/bin/xmr-stak /miners/xmr-stak
mv /miners/source/xmr-stak/build/bin/*.so /miners/xmr-stak
cp /miners/source/EasyMPH/miners/xmr-stak/*.txt /miners/xmr-stak

#xmrig
mv /miners/source/xmrig/build/xmrig /miners/xmrig

#DSTM's ZM
cp /miners/source/EasyMPH/miners/zm/* /miners/zm

#Claymore's ETH Dual Miner
cp /miners/source/EasyMPH/miners/ethdcrminer/* /miners/ethdcrminer

cd /miners/xmr-stak
sed -i "s/username.workername/$1.$2/g" pools.txt

cd /miners
cp /miners/source/EasyMPH/scripts/plloop.sh .
cp /miners/source/EasyMPH/scripts/automine.sh .
sed -i "s/username.workername/$1.$2/g" automine.sh

#start automine.sh in screen session
screen -dmS automine /miners/automine.sh

#add automine.sh to crontab for automatic mining on reboot
touch crontab.txt
crontab -l > crontab.txt

if grep -q "@reboot screen -dmS automine /miners/automine.sh" "./crontab.txt"
then
  echo "crontab already configured for auto-mining." 1>&2
elif grep -q "@reboot" "./crontab.txt"
then
  echo "Warning: crontab already contains a process which is launched on reboot. You will need to configure crontab manually." 1>&2
  crontab -e
else
  echo "@reboot screen -dmS automine /miners/automine.sh" >> crontab.txt
  crontab crontab.txt
fi

#all done
sleep 10
clear
echo "Installation complete, launching screen session." 1>&2
sleep 20
screen -r automine
