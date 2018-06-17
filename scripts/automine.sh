while :
  do
	killall ccminer; killall zm; killall xmr-stak
	
    #cryptonight
    cd /miners/xmr-stak
    ./xmr-stak

    #equihash
    cd /miners/zm
    ./zm --noreconnect --server europe.equihash-hub.miningpoolhub.com --port 12023 --user username.workername --pass x

    #ethash

    #groestl
    cd /miners/ccminer
    ./ccminer -r 0 -a groestl -o stratum+tcp://hub.miningpoolhub.com:12004 -u username.workername -p x --api-bind=2222

    #lyra2RE2
    cd /miners/ccminer
    ./ccminer -r 0 -a lyra2v2 -o stratum+tcp://hub.miningpoolhub.com:12018 -u username.workername -p x --api-bind=2222

    #lyra2z
    cd /miners/ccminer
    ./ccminer -r 0 -a lyra2z -o stratum+tcp://europe.lyra2z-hub.miningpoolhub.com:12025 -u username.workername -p x --api-bind=2222

    #myriad-groestl
    cd /miners/ccminer
    ./ccminer -r 0 -a myr-gr -o stratum+tcp://hub.miningpoolhub.com:12005 -u username.workername -p x --api-bind=2222

    #neoscrypt
    cd /miners/ccminer
    ./ccminer -r 0 -a neoscrypt -o stratum+tcp://hub.miningpoolhub.com:12012 -u username.workername -p x -i 19 --api-bind=2222

    #skein
    cd /miners/ccminer
    ./ccminer -r 0 -a skein -o stratum+tcp://hub.miningpoolhub.com:12016 -u username.workername -p x --api-bind=2222

  done
