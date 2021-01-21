# aosp-riscv

## Overview
T-Head has ported Android 10 on RISC-V architecture. Android's primary purpose is to create an open software platform available for carriers, OEMs, and developers to make their innovative ideas a reality and to introduce a successful, real-world product that improves the mobile experience for users. [Video for Android on XuanTie910](https://dummy.dummy)

![aosp.gif](https://github.com/T-head-Semi/aosp-riscv/blob/main/resources/aosp.gif?raw=true)
Graph 1. AOSP on RISC-V 64(XuanTie 910)

## Chip
ICE EVB is a XuanTie C910 based high performance SoC board developed by T-Head. The ICE SoC has intergrated 3 XuanTie C910 cores (RISC-V 64) and 1 GPU core; featuring speed and intelligence with a high cost-effective ratio. The chip can provide 4K@60 HEVC/AVC/JPEG decoding ability, and varieties of high-speed interfaces and peripherals for controling and data exchange; suits for 3D graphics, visual AI and multimedia processing.

![ice.png](https://github.com/T-head-Semi/aosp-riscv/blob/main/resources/ice.jpg?raw=true)

Graph 2. ICE chip

For more information about XuanTie 910 CPU core IP, please check: [**XuanTie C910 introduction**](https://occ.t-head.cn/vendor/cpu/index?spm=a2cl5.14294226.0.0.6700df2098XZyN&id=3806788968558108672)

## Open source
This port bases on android10-release (platform/manifest 1c222b02bde285fe1272b4440584750154d3882d). All the source code developed by T-HEAD are contained in the repository, anyone interested in this project can reproduce the emulator environment following the instructions from: [**Quick start**](https://github.com/T-head-Semi/aosp-riscv/blob/master/QUICKSTART.md)
