#!/bin/bash
default_wallets_num=7
wallets_number=${1:-$default_wallets_num}

create_wallets() {
    for (( i=1; i <= $wallets_number; i++ ))
    do

    pin=$(seq -w 9999 | head -n $i | tail -1)

        echo "Creating $i wallet with pin $pin"
        mkdir -p "wallet_$i"
        cd wallet_$i
        tagionwallet --generate-wallet --questions q1,q2,q3,q4 --answers a1,a2,a3,a4 -x $pin
        tagionwallet --create-invoice GENESIS:100000 -x $pin
        tagionboot invoice_file.hibon -o genesis.hibon
        cd ../
        dartutil --dartfilename /home/moonbase/tagion_network/data/dart.drt --modify --inputfile /home/moonbase/tagion_network/wallet_$i/genesis.hibon
    done
}

mkdir -p tagion_network
cd tagion_network

mkdir -p data/node0
mkdir shared
cd data
dartutil --initialize --dartfilename dart.drt
cd ../
create_wallets
cp /home/moonbase/tagion_network/data/dart.drt /home/moonbase/tagion_network/data/node0/dart.drt
                                          
