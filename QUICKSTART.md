# QUICKSTART

Before downloading AOSP source code please check you work enviroment, Linux system(Ubuntu is suggested) with more than 200G disk space and more than 8 cpu cores(otherwise it will take really long time to compile). Then the instructions from following links to setup build enviroment:

https://source.android.com/setup/develop#installing-repo

https://source.android.com/setup/build/initializing

Run reproduce.sh to download aosp to current dir and compile the AOSP on riscv emulator. If repo sync is abort for network reason, just re-run the reproduce.sh script. Finally use the following cmd to start emulator:

cd {AOSP_RISCV_BUILD_TOP}

source ./build/envsetup.sh

lunch aosp_riscv64-eng

emulator -selinux permissive -qemu -smp 2 -m 3800M -bios ${AOSP_RISCV_BUILD_TOP}/prebuilts/qemu-kernel/riscv64/ranchu/fw_jump.bin
