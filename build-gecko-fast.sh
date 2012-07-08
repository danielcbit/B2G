#!/bin/bash

. setup.sh
for str in "$@"; do
    echo "CMDLINE:$str"
    make -C $GECKO_OBJDIR/$str $MAKE_FLAGS
    ret=$?
    echo -ne \\a
    if [ $ret -ne 0 ]; then
        echo \> Build failed\! \<
        exit $ret;
    fi
done
cp -rf $GECKO_OBJDIR/toolkit/library/libxul.so /tmp/
$ANDROID_TOOLCHAIN/arm-linux-androideabi-strip /tmp/libxul.so
adb push /tmp/libxul.so /system/b2g/
adb shell stop b2g
adb shell start b2g

ret=$?
echo -ne \\a
if [ $ret -ne 0 ]; then
    echo \> Build failed\! \<
fi

exit $ret
