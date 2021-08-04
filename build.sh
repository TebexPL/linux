#! /bin/bash


#FOR CROSS COMPILING
#replace $MY_CROSS_COMPILE below with path to your cross compiler
#example:
#export CROSS_COMPILE=/home/user/Desktop/arm-eabi-8.x/bin/arm-eabi-;
#export CROSS_COMPILE=$MY_CROSS_COMPILE;

export ARCH=x86 && SUBARCH=x86;
#replace 4 with number of threads your host CPU has
export CORECOUNT=5;
export DEFNAME="$(hostname)_defconfig"

if [[ ! -e arch/x86/configs/$DEFNAME ]]; then
  cp CONFIGS/xanmod/gcc/config arch/x86/configs/$DEFNAME;
fi

echo "Kernel build script.";
echo ;
echo "Press:";
echo "c to compile";
echo "m to open menuconfig and update my_defconfig afterwards";
echo "i to install kernel after compilation";
echo "r to reboot after kernel install";
echo "q to exit";


while [[ $input != "q" ]]; do
  input=" ";
  read -N 1 input;
  clear;
  if [[ $input == "c" ]]; then
    clear;
    make $DEFNAME;
    make -j$CORECOUNT;
  elif [[ $input == "m" ]]; then
    clear;
    make menuconfig;
    cp .config arch/x86/configs/$DEFNAME;
  elif [[ $input == "i" ]]; then
    clear;
    make modules_install;
    make install;
  elif [[ $input == "r" ]]; then
    clear;
    reboot;
  fi
  echo "Done!";
done;

clear;
