# aosp-riscv

## Overview
T-Head has ported Android 10 on RISC-V process, and intergrated the whole system on ICE SoC board. Android's primary purpose is to create an open software platform available for carriers, OEMs, and developers to make their innovative ideas a reality and to introduce a successful, real-world product that improves the mobile experience for users. [Video for Android on XuanTie910](https://dummy.dummy)

![aosp.gif](https://dummy.dummy)
Graph 1. AOSP on XuanTie 910（RISC-V 64）

## Chip
ICE EVB is a XuanTie C910 based high performance SoC board developed by T-Head. The ICE SoC has intergrated 3 XuanTie C910 cores (RISC-V 64), 1 NN core and 1 GPU core; featuring speed and intelligence with a high cost-effective ratio. Each chip can provide computer performance up to 0.5TOPS@INT8, 4K@60 HEVC/AVC/JPEG decoding ability, and varieties of high-speed interfaces and peripherals for controling and data exchange; suits for 3D graphics, visual AI and multimedia processing.
* Dual core T-Head XuanTie C910@1.2GHz
* Extra C910V@1.2GHz core with vector extension, up to 128bit
* DDR4 with speed up to 2400Mbps
* Support GMAC interface
* Support GPU and 3D
* Display: RGB888 LED, 1080P
* Performance: 0.5TOPS@INT8
* Chip size：15x15mm
* Scaling： 28HPC+

![ice.png](https://dummy.dummy)

Graph 2. ICE chip

For more information about XuanTie 910 CPU core IP, please check: [**XuanTie C910 introduction**](https://occ.t-head.cn/vendor/cpu/index?spm=a2cl5.14294226.0.0.6700df2098XZyN&id=3806788968558108672)

## Open source
This port bases on android10-release (platform/manifest 1c222b02bde285fe1272b4440584750154d3882d). Both emulator and ICE support are released in the repository, anyone interested in this project can reproduce the emulator environment following the instructions from: [**Quick start**](https://github.com/T-head-Semi/aosp-riscv/blob/master/QUICKSTART.md)
