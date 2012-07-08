#!/bin/bash

. setup.sh
CURDIR=$(pwd)
TARGET_PATH=$(pwd)/out/target/product/$DEVICE
TOOLCHAIN=$ANDROID_EABI_TOOLCHAIN/arm-linux-androideabi-
KERNEL_PATH=$CURDIR/boot/kernel-$VENDOR-$DEVICE
KERNEL_PATH_BLD=$KERNEL_PATH/debian/build/kernel

rm -rf $KERNEL_PATH_BLD
echo "mkdir $KERNEL_PATH_BLD"
mkdir -p $KERNEL_PATH_BLD
echo "mkdir $KERNEL_PATH_BLD"
mkdir -p $KERNEL_PATH_BLD
cd $KERNEL_PATH && tar cf - `echo * | sed -e 's/ debian//g' -e 's/\.deb//g' ` | (cd $KERNEL_PATH_BLD ; umask 000; tar xspf -)
echo "cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN rm581_nitdroid_defconfig"
cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN rm581_nitdroid_defconfig
echo "cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS zImage"
cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS zImage
echo "cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS modules"
cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS modules
echo "cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS modules_prepare"
cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS modules_prepare
echo "cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN INSTALL_MOD_PATH=$TARGET_PATH/system modules_install"
cd $KERNEL_PATH_BLD && make ARCH=arm CROSS_COMPILE=$TOOLCHAIN INSTALL_MOD_PATH=$TARGET_PATH/system modules_install
cd $CURDIR
