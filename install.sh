# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get --assume-yes install git automake autotools-dev build-essential cmake libcurl4-openssl-dev libhwloc-dev libjansson-dev libssl-dev libuv1-dev nvidia-cuda-dev nvidia-cuda-toolkit gcc-5 g++-5 libmicrohttpd-dev

mkdir -p /miners/source
cd /miners/source

#Clone CCMiner source from GitHub
git clone https://github.com/tpruvot/ccminer.git

#Clone xmr-stak source from GitHub
git clone https://github.com/fireice-uk/xmr-stak.git

#Clone xmrig source from GitHub
git clone https://github.com/xmrig/xmrig.git

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

#Move files
#CCMiner
mv /miners/source/ccminer/ccminer /miners/ccminer

#xmr-stak
mv /miners/source/xmr-stak/build/bin/xmr-stak /miners/xmr-stak
mv /miners/source/xmr-stak/build/bin/*.so /miners/xmr-stak

#xmrig
mv /miners/source/xmrig/build/xmrig /miners/xmrig
