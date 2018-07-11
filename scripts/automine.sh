
#uncomment below line to repeatedly tell nvidia-smi to limit power usage. There's definitely a better way to do this, but it works for now.
#screen -dmS power-limiter /miners/plloop.sh 5

while :
  do
    killall ccminer; killall zm; killall xmr-stak; killall ethdcrminer64;
    #cryptonight
    clear
    date
    cd /miners/xmr-stak
    ./xmr-stak

    #equihash
    clear
    date
    cd /miners/zm
    ./zm --noreconnect --server europe.equihash-hub.miningpoolhub.com --port 12023 --user username.workername --pass x --telemetry=0.0.0.0:2222

    #ethash
    #clear
    #date
    #cd /miners/ethdcrminer
    #./ethdcrminer64 -epool us-east.ethash-hub.miningpoolhub.com:12020 -ewal username.workername -eworker username.workername -esm 2 -epsw x -allcoins 1 -dbg -1 -retrydelay -1 -mport -2222

    #groestl
    clear
    date
    cd /miners/ccminer
    ./ccminer -r 0 -a groestl -o stratum+tcp://hub.miningpoolhub.com:12004 -u username.workername -p x --api-bind=2222

    #lyra2RE2
    clear
    date
    cd /miners/ccminer
    ./ccminer -r 0 -a lyra2v2 -o stratum+tcp://hub.miningpoolhub.com:12018 -u username.workername -p x --api-bind=2222

    #lyra2z
    clear
    date
    cd /miners/ccminer
    ./ccminer -r 0 -a lyra2z -o stratum+tcp://europe.lyra2z-hub.miningpoolhub.com:12025 -u username.workername -p x --api-bind=2222

    #myriad-groestl
    clear
    date
    cd /miners/ccminer
    ./ccminer -r 0 -a myr-gr -o stratum+tcp://hub.miningpoolhub.com:12005 -u username.workername -p x --api-bind=2222

    #neoscrypt
    clear
    date
    cd /miners/ccminer
    ./ccminer -r 0 -a neoscrypt -o stratum+tcp://hub.miningpoolhub.com:12012 -u username.workername -p x -i 19 --api-bind=2222

    #skein
    clear
    date
    cd /miners/ccminer
    ./ccminer -r 0 -a skein -o stratum+tcp://hub.miningpoolhub.com:12016 -u username.workername -p x --api-bind=2222

  done
