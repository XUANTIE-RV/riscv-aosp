# Overview

![aosp.gif](https://github.com/T-head-Semi/aosp-riscv/blob/main/resources/aosp.gif?raw=true)
Graph 1. AOSP on RISC-V 64(XuanTie 910)

[Video for Android on XuanTie910](https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/share/riscv_android_demo.mp4)

# Chip
ICE is a XuanTie C910 based high performance SoC board developed by T-Head. The ICE SoC has integrated 3 XuanTie C910 cores (RISC-V 64) and 1 GPU core; featuring speed and intelligence with a high cost-effective ratio. The chip can provide 4K@60 HEVC/AVC/JPEG decoding ability, and varieties of high-speed interfaces and peripherals for controlling and data exchange; suits for 3D graphics, visual AI and multimedia processing.

![ice.jpg](https://github.com/T-head-Semi/aosp-riscv/blob/main/resources/ice.jpg?raw=true)

Graph 2. ICE chip

For more information about XuanTie 910 CPU core IP, please check: [**XuanTie C910 introduction**](https://occ.t-head.cn/vendor/cpu/index?spm=a2cl5.14294226.0.0.6700df2098XZyN&id=3806788968558108672)

# Board
RVB-ICE is development board based on ICE. It is equipped with 7-inch LCD touch screen,  integrates WIFl and GMACnetwork communication interface, has 16GB EMMC memory,  and supports interfaces such as Bluetooth keyboard and mouse.

![rvb_ice.jpg](https://github.com/T-head-Semi/aosp-riscv/blob/main/resources/rvb_ice.jpg?raw=true)

The board detail and pre-order link can be found in page: [**RVB-ICE**](https://occ.t-head.cn/community/risc_v_en/detail?id=RVB-ICE)

# QUICKSTART
This port is based on android10-release (platform/manifest 1c222b02bde285fe1272b4440584750154d3882d). All the source code developed by T-Head is contained in the repository, anyone interested in this project can reproduce the environment with RVB-ICE/emulator.

Before downloading AOSP source code please check you work environment, it is recommended to install a Linux system(Ubuntu 16.04 is preferred) with at list 200G disk space and more than 8 CPU cores. Then follow the instructions from the links below:

https://source.android.com/setup/develop#installing-repo

https://source.android.com/setup/build/initializing

To setup the build enviroment, run reproduce.sh to download aosp to current directory and build AOSP for RISC-V. If repo sync is aborted, re-run the script.

## Setup emulator environment

Run the reproduce.sh with no argument, the reproduce.sh will lunch the config "aosp_riscv64-eng", and compile all the required images for emulator environment.

Finally, use the following command to start emulator:

```
cd ${AOSP_RISCV_BUILD_TOP}
source ./build/envsetup.sh
lunch aosp_riscv64-eng
emulator -selinux permissive -qemu -smp 2 -m 3800M -bios ${AOSP_RISCV_BUILD_TOP}/prebuilts/qemu-kernel/riscv64/ranchu/fw_jump.bin
```

## Setup RVB-ICE environment
### Prepare binaries
Run the reproduce.sh with an argument "ice", the reproduce.sh will lunch the config "ice910dk-userdebug", and compile all the required images for the RVB-ICE.

The final images will be under:
```
aosp/out/target/product/ice910dk/
aosp/device/thead/thead_ice910/kernel/

The required image files include:
ramdisk.img
kernel
system.img
thead-ice910.dtb
u-boot-with-spl.bin
userdata.img
vendor.img

Copy these file to fastboot dir:
 mkdir fastboot
 cp aosp/out/target/product/ice910dk/ramdisk.img fastboot/boot
 cp aosp/out/target/product/ice910dk/kernel fastboot/boot/uImage
 cp aosp/out/target/product/ice910dk/system.img fastboot
 cp aosp/out/target/product/ice910dk/thead-ice910.dtb fastboot/boot
 cp aosp/out/target/product/ice910dk/userdata.img fastboot
 cp aosp/out/target/product/ice910dk/vendor.img fastboot
 cp aosp/device/thead/thead_ice910/kernel/fw_jump.bin fastboot/boot
 cp aosp/device/thead/thead_ice910/kernel/u-boot-with-spl.bin fastboot
 cd fastboot
```

Create boot image:
```
 make_ext4fs -l 20M boot.ext4 boot/
```

### Program the device
Connect the power socket to 5V power supply, and the USB Type-C connector to host computer.

![rvb_ice_port.jpg](https://github.com/T-head-Semi/aosp-riscv/blob/main/resources/rvb_ice_port.jpg?raw=true)

You can program the device with the files under fastboot directory or prebuilt images downloaded from this link:
[**Prebuilt images**](https://rosp-riscv.oss-cn-hangzhou.aliyuncs.com/prebuilts/images/ice/android-rvb-ice-images_20210113.tar.bz2)

Press the reboot button on the board; type in any key to get into console mode when the following prompt shows on the terminal.

```
Warning: ethernet@3fffc0000 (eth0) using random MAC address - a6:7d:bc:02:7d:4d
eth0: ethernet@3fffc0000
Hit any key to stop autoboot:  3
```

Use the `gpt` tool to config the eMMC partitions size:

```bash
# reset to default env
env default -a

# Config the eMMC partitions size
setenv partitions "name=sparse,size=2031kb"
setenv partitions "$partitions;name=bootpart,size=60MiB"
setenv partitions "$partitions;name=system,size=1500MiB"
setenv partitions "$partitions;name=vendor,size=100MiB"
setenv partitions "$partitions;name=cache,size=256MiB"
setenv partitions "$partitions;name=userdata,size=-"

gpt write mmc 0 $partitions

# Config the network

# !!!!!!!!!!!!!!!!!!!! Special attention !!!!!!!!!!!!!!!!!!!!!!!!
# If multiple boards are connected to the network, each ethaddr shall be unique
setenv ethaddr 00:a0:a0:a0:a0:a1
setenv ipaddr 192.168.1.100        # Set dev board IP address
setenv netmask 255.255.255.0
ping 192.168.1.1                   # ping host IP，check network connection

# Config the kernel initialization parameter bootargs

setenv bootargs "console=ttyS0,115200"
setenv bootargs "$bootargs root=PARTUUID=$uuid_rootfs rootfstype=ext4"
setenv bootargs "$bootargs earlycon=sbi rdinit=/init security=selinux"
setenv bootargs "$bootargs crashkernel=256M-:128M c910_mmu_v1 printk.devkmsg=on"
setenv bootargs "$bootargs androidboot.selinux=permissive"
setenv bootargs "$bootargs androidboot.hardware=ranchu"
setenv bootargs "$bootargs androidboot.super_partition"

# Config bootcmd
setenv bootcmd "ext4load mmc 0:2 $opensbi_addr fw_jump.bin"
setenv bootcmd "$bootcmd;ext4load mmc 0:2 $dtb_addr ice_evb_c910.dtb"
setenv bootcmd "$bootcmd;ext4load mmc 0:2 $kernel_addr uImage"
setenv bootcmd "$bootcmd;ext4load mmc 0:2 0x02000000 ramdisk.img"
setenv bootcmd "$bootcmd;bootm $kernel_addr - $dtb_addr"

# Save environment variable to eMMC
saveenv

# Start fastboot udp
fastboot udp
```

Program the device using fastboot:
```
 sudo apt install fastboot
 fastboot -s udp:192.168.1.100 -S 5M flash boot output-android/boot.ext4
 fastboot -s udp:192.168.1.100 -S 5M flash system output-android/system.img
 fastboot -s udp:192.168.1.100 -S 5M flash vendor output-android/vendor.img
 fastboot -s udp:192.168.1.100 -S 5M flash cache output-android/cache.img
 fastboot -s udp:192.168.1.100 -S 5M flash userdata output-android/userdata.img
```

### Build kernel & u-boot
The kernel and u-boot images are under the prebuilt directory, it is required to recompile these files from the source if you want to change the configurations.

Export the aosp-riscv directory for copy reference.
```
cd aosp-riscv
export AOSP_RISCV_PATH=`pwd`
```

Get a RISC-V toolchain and install:
```
 mkdir rvtools
 cd rvtools
 wget https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource/1836682/1629195585549/Xuantie-900-gcc-linux-5.4.36-glibc-x86_64-V2.0.3-20210806.tar.gz
 tar -xf Xuantie-900-gcc-linux-5.4.36-glibc-x86_64-V2.0.3-20210806.tar.gz
 export PATH=`pwd`/bin:$PATH
```

Build u-boot:
```
 git clone https://gitee.com/thead-linux/u-boot.git
 cd u-boot
 make ARCH=riscv ice_evb_c910_defconfig
 make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- -j
 cp u-boot-with-spl.bin $(AOSP_RISCV_PATH)/device/thead/thead_ice910/kernel/
```

Build kernel:
```
 git clone https://github.com/T-head-Semi/linux.git
 cd kernel
 git checkout  origin/linux-5.4-aosp
 make ARCH=riscv ice_c910_defconfig
 make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- -j Image dtbs
 mkdir ../output-kernel
 mkimage -A riscv -O linux -T kernel -C none -a 0x00200000 -e 0x00200000 -n Linux -d ./arch/riscv/boot/Image ./uImage
 cp uImage $(AOSP_RISCV_PATH)/device/thead/thead_ice910/kernel/kernel
 cp arch/riscv/boot/dts/thead/ice_evb_c910.dtb $(AOSP_RISCV_PATH)/device/thead/thead_ice910/kernel/
```
