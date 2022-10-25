#!/bin/bash
function center ()
{
 _STR=$1
 _ROW=$2
 LEN=`echo $_STR | wc -c`
 COLS=`tput cols`
 HOLD_COL=`expr $COLS - $LEN`
 NEW_COL=`expr $HOLD_COL / 2`
 tput cup $_ROW $NEW_COL
 echo -n $_STR
}
printf "\t\t ###build_script_v1.1 by lijinghong \n"
printf "\t\t ###web page building\n"
cd /home/qlu_mirrors/mirror-web/
jekyll build
printf  "\t\t ###mirror files linking\n"
ln -s /mnt/vos-6izqwyw8/mirrors/centos/  /home/qlu_mirrors/mirror-web/_site/
ln -s /mnt/vos-6izqwyw8/mirrors/archlinux/  /home/qlu_mirrors/mirror-web/_site/
ln -s /mnt/vos-6izqwyw8/mirrors/ros/  /home/qlu_mirrors/mirror-web/_site/
ln -s /mnt/vos-6izqwyw8/mirrors/ubuntu/  /home/qlu_mirrors/mirror-web/_site/
ln -s /mnt/vos-6izqwyw8/mirrors/kali/  /home/qlu_mirrors/mirror-web/_site/
printf "\t\t ###done\n"
