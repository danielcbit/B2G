#!/bin/bash

. setup.sh &&
CURDIR=$(pwd)
cd $(ANDROID_BUILD_TOP)/boot/kernel-$VENDOR-$DEVICE
TOOLCHAIN=$ANDROID_EABI_TOOLCHAIN/arm-linux-androideabi-
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN rm581_nitdroid_defconfig
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN $MAKE_FLAGS
cd $CURDIR

