#!/bin/bash
export host=192.168.1.150
export remotedir=/home/player/Videos/
export dir=/Users/macmini/Desktop/InfoScreenFoyer
export work=/users/macmini/.infoscreensync

touch $work/sync.lock

if [ -f $$work/sync.lock ]
  then
   echo "Sync is running..."
   exit 0 
fi


shasum $dir/*.m4v > $work/current

cmp $work/current $work/last
if [ $? -eq 1 ]; then
    scp -r $dir $host:$remotedir
    mv $work/current $work/last
    ssh -c 'sudo service lightdm restart' $host
fi

rm $work/sync.lock
