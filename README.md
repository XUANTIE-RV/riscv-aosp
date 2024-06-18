# XuanTie Android

This repository is maintained by Damo Academy Xuantie Team for the support of the Android Open Source Project (AOSP) on XuanTie CPU based development boards. It mainly includes BSP configuration, peripheral HAL layer, kernel, u-boot, and pre-compiled component support for the development boards. Other components can be directly pulled from the upstream AOSP repository. Currently, the repository maintains the relevant support for BeagleV Ahead and Lichee Pi 4A development boards based on the [TH1520](https://xrvm.com/soc-details?id=4095189586886594560) SoC prototype.

Chinese page:

https://gitee.com/thead-android/thead-android/blob/master/README.md

The historical versions (RVB-ICE support) of this repository have been backed up to the branch:

https://github.com/XUANTIE-RV/riscv-aosp/tree/back_up

## Development boards
### BeagleV Ahead
BeagleV Ahead is a development board product launched by Beagle board, which supports multiple operating systems such as Android, Debian, Ubuntu, etc. The development board integrates TH1520 SoC, which includes a quad-core Xuan Tie C910 processor running at 1.85G and an NPU with 4TOPS computing power. It has a built-in GPU that supports OpenGL ES, OpenCL, and Vulkan, and features various device interfaces such as USB, Wi-Fi/BT, Ethernet, HDMI, MIPI CSI/DSI, etc. It can be used in AI edge computing applications such as video conferencing all-in-one machines, face recognition attendance access control, medical imaging, etc.
![beaglev](https://github.com/T-head-Semi/riscv-aosp/blob/main/resources/beaglev.jpeg?raw=true)

Figure 1. BeagleV Ahead

For more information, please visit the Beagleboard documentation page:

https://beaglev-ahead.beagleboard.io/docs/latest/boards/beaglev/ahead/index.html

### Lichee Pi 4A EVB
Lichee Pi 4A is a development board product launched by Sipeed, which supports multiple operating systems such as Android, Debian, OpenWrt, etc. The development board integrates TH1520 SoC, which includes a quad-core Xuan Tie C910 processor running at 1.85G and an NPU with 4TOPS computing power. It has a built-in GPU that supports OpenGL ES, OpenCL, and Vulkan, and features various device interfaces such as USB, Wi-Fi/BT, Ethernet, HDMI, MIPI CSI/DSI, etc. It can be used in AI edge computing applications such as video conferencing all-in-one machines, face recognition attendance access control, medical imaging, etc.
![licheepi4a](https://github.com/XUANTIE-RV/riscv-aosp/blob/main/resources/licheepi4a.png?raw=true)

Figure 2. Lichee Pi 4A EVB

For more information, please visit the Sipeed Wiki page:
https://wiki.sipeed.com/licheepi4a

## Quick start
Before downloading the Android Open Source Project source code, please check your working environment. It is recommended to use a Linux system with at least 250G disk space and 16GB+ memory (Ubuntu 20.04 or above is recommended). The compilation time is related to the number of processor cores on the host, so it is recommended to use a host with more cores.

Download the Android Open Source Project (mainline version) and the development board support source code to your working directory.
```
mkdir riscv-android-src && cd riscv-android-src
repo init -u https://android.googlesource.com/platform/manifest -b master
git clone https://gitee.com/XUANTIE-RV/local_manifests.git .repo/local_manifests -b thead-android_dev
repo sync
```

### BeagleV Ahead
After downloading, you can build the system using the following commands:
```
source build/envsetup.sh
lunch beaglev_ahead-userdebug
m -j
```

The compiled files are shown below, and the required files can be copied for use with Fastboot:
```
$ ls out/target/product/beaglev_ahead/*img
out/target/product/beaglev_ahead/boot.img           out/target/product/beaglev_ahead/super_empty.img        out/target/product/beaglev_ahead/vendor_boot-debug.img
out/target/product/beaglev_ahead/cache.img          out/target/product/beaglev_ahead/system.img             out/target/product/beaglev_ahead/vendor_boot-test-harness.img
out/target/product/beaglev_ahead/dtb.img            out/target/product/beaglev_ahead/system_ext.img         out/target/product/beaglev_ahead/vendor_boot.img
out/target/product/beaglev_ahead/dtbo-unsigned.img  out/target/product/beaglev_ahead/userdata.img           out/target/product/beaglev_ahead/vendor_ramdisk-debug.img
out/target/product/beaglev_ahead/dtbo.img           out/target/product/beaglev_ahead/vbmeta.img             out/target/product/beaglev_ahead/vendor_ramdisk-test-harness.img
out/target/product/beaglev_ahead/product.img        out/target/product/beaglev_ahead/vbmeta_system.img      out/target/product/beaglev_ahead/vendor_ramdisk.img
out/target/product/beaglev_ahead/ramdisk.img        out/target/product/beaglev_ahead/vendor-bootconfig.img
out/target/product/beaglev_ahead/super.img          out/target/product/beaglev_ahead/vendor.img

$ mkdir fastboot
$ cd out/target/product/beaglev_ahead/
$ cp u-boot-with-spl.bin bootpart.ext4 boot.img super.img userdata.img vbmeta.img vbmeta_system.img vendor_boot.img ../../../../../fastboot/
```

![beaglev_connect](https://github.com/XUANTIE-RV/riscv-aosp/blob/main/resources/beaglev_connect.png?raw=true)

Figure 3. BeagleV Ahead Connection.

The main connections required to use the development board include power, serial port, USB, and display:
- The serial port is mainly used for command interaction in U-boot and the kernel, and can be connected through the Debug RX and TX on the bottom of the board, with a baud rate of 115200.
- The USB Device interface is mainly used for the connection of fastboot and adb tools.
- The MIPI DSI/HDMI interface can be used to connect the screen to display the UI interface. 

To perform a full system write, press the USB button on the development board and simultaneously press the reset button to enter the boot write mode.

Then use fastboot to write the system image. ADB and fastboot tools can be downloaded from the Android developer website:
https://developer.android.com/tools/releases/platform-tools

```
#Program U-boot and initialize boot environment variables
fastboot flash ram u-boot-with-spl.bin
fastboot reboot
fastboot flash uboot u-boot-with-spl.bin

#Program various partitions
#In non-boot write mode, you can enter the command fastboot usb 0 on the uboot command line to write individual partitions separately.
fastboot flash bootpart bootpart.ext4
fastboot flash boot boot.img
fastboot flash vendor_boot vendor_boot.img
fastboot flash super super.img 
fastboot flash userdata userdata.img
fastboot flash vbmeta vbmeta.img
fastboot flash vbmeta_system vbmeta_system.img

#Initialize metadata and misc partitions
fastboot erase metadata 
fastboot erase misc
```
After writing, reset and power on the board to enter the system boot mode. You can access the system command line through the serial port/ADB and interact with the system image interface through the touch screen or external HDMI display.

![beaglev_aosp](https://github.com/XUANTIE-RV/riscv-aosp/blob/main/resources/beaglev_aosp.png?raw=true)

Figure 4. Running AOSP main branch on BeagleV Ahead.

### Lichee Pi 4A EVB
After downloading, you can build the system using the following commands:
```
source build/envsetup.sh
lunch lichee_pi_4a-userdebug
m -j
```

The compiled files are shown below, and the required files can be copied for use with Fastboot:
```
$ ls out/target/product/lichee_pi_4a/*img
out/target/product/lichee_pi_4a/boot.img           out/target/product/lichee_pi_4a/super_empty.img        out/target/product/lichee_pi_4a/vendor_boot-debug.img
out/target/product/lichee_pi_4a/cache.img          out/target/product/lichee_pi_4a/system.img             out/target/product/lichee_pi_4a/vendor_boot-test-harness.img
out/target/product/lichee_pi_4a/dtb.img            out/target/product/lichee_pi_4a/system_ext.img         out/target/product/lichee_pi_4a/vendor_boot.img
out/target/product/lichee_pi_4a/dtbo-unsigned.img  out/target/product/lichee_pi_4a/userdata.img           out/target/product/lichee_pi_4a/vendor_ramdisk-debug.img
out/target/product/lichee_pi_4a/dtbo.img           out/target/product/lichee_pi_4a/vbmeta.img             out/target/product/lichee_pi_4a/vendor_ramdisk-test-harness.img
out/target/product/lichee_pi_4a/product.img        out/target/product/lichee_pi_4a/vbmeta_system.img      out/target/product/lichee_pi_4a/vendor_ramdisk.img
out/target/product/lichee_pi_4a/ramdisk.img        out/target/product/lichee_pi_4a/vendor-bootconfig.img
out/target/product/lichee_pi_4a/super.img          out/target/product/lichee_pi_4a/vendor.img

$ mkdir fastboot
$ cd out/target/product/lichee_pi_4a/
$ mkdir fastboot
$ cp bootpart.ext4 boot.img super.img userdata.img vbmeta.img vbmeta_system.img vendor_boot.img ../../../../../fastboot/
```

![licheepi4a_connect](https://github.com/XUANTIE-RV/riscv-aosp/blob/main/resources/licheepi4a_connect.png?raw=true)

Figure 5. Lichee Pi 4A EVB connect

The main connections required to use the development board include power, serial port, USB, and display:

- The serial port is mainly used for command interaction in U-boot and the kernel, and can be connected through the U0-RX and U0-TX GPIO on the bottom of the board, with a baud rate of 115200.
- The USB Device interface is mainly used for the connection of fastboot and adb tools.
- The MIPI DSI/HDMI interface can be used to connect the screen to display the UI interface. 

To perform a full system write, press the boot button on the development board and simultaneously press the reset button to enter the boot write mode.

Then use fastboot to write the system image. ADB and fastboot tools can be downloaded from the Android developer website:
https://developer.android.com/tools/releases/platform-tools

```
#Program U-boot and initialize boot environment variables
fastboot flash ram u-boot-with-spl.bin
fastboot reboot
fastboot flash uboot u-boot-with-spl.bin

#Program various partitions
#In non-boot write mode, you can enter the command fastboot usb 0 on the uboot command line to write individual partitions separately.
fastboot flash bootpart bootpart.ext4
fastboot flash boot boot.img
fastboot flash vendor_boot vendor_boot.img
fastboot flash super super.img
fastboot flash userdata userdata.img
fastboot flash vbmeta vbmeta.img
fastboot flash vbmeta_system vbmeta_system.img

#Initialize metadata and misc partitions
fastboot erase metadata
fastboot erase misc
```
After writing, reset and power on the board to enter the system boot mode. You can access the system command line through the serial port/ADB and interact with the system image interface through the touch screen or external HDMI display.

![licheepi4a_aosp](https://github.com/XUANTIE-RV/riscv-aosp/blob/main/resources/licheepi4a_aosp.png?raw=true)

Figure 6. Running AOSP Mainline on Lichee Pi 4A

(If you need more optimized and stable system support, please contact us to obtain Android 12 version support. This version has a more complete system components and peripheral HAL support, adapted for GPU, VPU, Camera, Audio, NPU and other peripheral hardware, and has undergone more comprehensive XTS testing and stress testing.
You can obtain relevant support through the "work order system" in the "About Us" section.)

## Change list
2023/07/06

- Release BeagleV Ahead development board Alpha support
- Release Lichee Pi 4A EVB Alpha support

## Contribute
This project accepts external contributions through Pull Requests. The following process can be referred to:

1. Fork the modified repository into a personal account.
2. Create a development branch named suitably for your work.
3. Replace the project remote and revision with your own repository:
```
- <project path="device/thead/common" name="device-thead-common" revision="alpha_0_2_0" remote="thead" />
+ <project path="device/thead/common" name="device-thead-common" revision="alpha_0_2_0_xxx_support" remote="your_personal_remote" />
```
4. All new work should be based on the corresponding development branch.
5. When creating a submission, ensure that the changes are as independent and complete as possible, and provide appropriate submission messages.
6. It is recommended to include relevant unit test results when making changes.
7. Push the development branch to your personal repository fork on Github.
8. Create a Github Pull Request for the corresponding development branch. If the submission is for a bug fix, link it to the issue in the issue tracker.

## Releated link

The issue tracker for this project (for Android related issues on the Development Board, please submit to this tracker):

https://gitee.com/thead-android/thead-android/issues

Other open source software projects by Flathead Brother can be accessed through the following links:

XuanTie Yocto Linux: https://gitee.com/thead-yocto

YoC Open: https://gitee.com/yocop

If you want to learn more about TH1520 and Wujian 600 platform, please visit:

https://www.xrvm.cn/product/wujian/600

If you want to learn more about the dynamic support of RISC-V architecture on Android, you can subscribe to the RISC-V Android SIG mailing list and participate in community discussions:

https://lists.riscv.org/g/sig-android

If you have any questions about Android support for RISC-V architecture, you can submit them to the generic issue tracker for Android-riscv64:

https://github.com/google/android-riscv64/issues

## License

We do not require any formal copyright assignment or contributor license agreement. Any contributions intentionally sent upstream are presumed to be offered under terms of the OSI-approved Apache License 2.0. See LICENSE file for details.

## About Us
This repository is maintained by Alibaba T-Head.

If you need technical support, you can submit a work order through OCC: 
https://www.xrvm.cn/people/workorder-submit

You can also contact us through the following ways:
E-mail: xuantie@service.alibaba.com
