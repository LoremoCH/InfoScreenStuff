#!/bin/bash
export host=192.168.1.150
export remotedir=/home/player/Videos/
export dir=/Users/X/InfoScreenFoyer
export work=/users/X/.infoscreensync

touch $work/sync.lock

shasum $dir/*.m4v > $work/current

cmp $work/current $work/last
if [ $? -eq 1 ]; then
    scp -r $dir $host:$remotedir
    mv $work/current $work/last
    ssh -c 'sudo reboot' $host
fi

rm $work/sync.lock
