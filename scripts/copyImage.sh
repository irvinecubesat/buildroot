#!/bin/bash
#
# Script to assist in copying the image files to a target root directory.  Directory will be
# named $targetDir/fsw_image-{version}
#

log()
{
    echo $*
}

#
# Extract version from issue in usr_local tar file
#
FSW_IMAGE_DIR=output/images/fsw_image
LOCAL_TAR=$FSW_IMAGE_DIR/usr_local.tar
if [ ! -e "$LOCAL_TAR" ]; then
  LOCAL_TAR=$FSW_IMAGE_DIR/fsw_image.usr_local.tar
fi
versionDirName=$(tar -Oxvf "$LOCAL_TAR" ./etc/issue | head -1|cut -d' ' -f 4-|sed -e "s/ - / /g;" -e "s/ /_/g;")
fsw_image_root=output/images/fsw_image
baseName=fsw_image
satIp=${SAT_IP-irvine-02}
target=root@$satIp
targetRootDir=/data
targetPath=${targetRootDir}/${baseName}-${versionDirName}
ssh $target mkdir -p ${targetPath}
if [ $? -ne 0 ]; then
    log "[E] Unable to make $targetPath on $target"
    exit 1
fi

log "[I] Copying image to ${target}:$targetPath"
scp "${fsw_image_root}"/*.{bin,sh,tcl,jffs2} ${target}:${targetPath}
if [ $? -ne 0 ]; then
    log "[E] copy files to $target:${targetPath}"
    exit 1
fi

echo "[I] Image copied to $targetPath on $target login and run install.sh, then reboot"
