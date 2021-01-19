#!/bin/bash
set -e
SCRIPT_PATH=`realpath $0`
export AOSP_RISCV_TOP=`dirname $SCRIPT_PATH`
export AOSP_RISCV_PATCH_TOP=${AOSP_RISCV_TOP}/patches
export AOSP_RISCV_BUILD_TOP=${AOSP_RISCV_TOP}/aosp
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'

#check path
if [ -z $AOSP_RISCV_TOP -o $AOSP_RISCV_TOP = "" ] ; then
    echo "Script path is not valid."
    exit -1
fi

mkdir -p stages

#check enviroment
check_tools(){
    for arg in "$@"
    do
        notfound=$(type $arg 2>&1)
        if [[ $notfound = *"not found"* ]]; then
            echo $arg not found !!!!!
            return -1;
        fi
    done
}

if ! check_tools gcc ld zip unzip curl git java repo; then
    echo "***************************************************************************************"
    echo
    echo "Required tools not found."
    echo "Please check https://source.android.com/setup/build/initializing for basic requirement."
    echo
    echo "***************************************************************************************"
    exit -1
fi

#download aosp
if [ ! -f ${AOSP_RISCV_TOP}/stages/.stamp_repo_sync ]; then
    mkdir -p ${AOSP_RISCV_BUILD_TOP}
    cd ${AOSP_RISCV_BUILD_TOP}
    repo init -u https://mirrors.tuna.tsinghua.edu.cn/git/AOSP/platform/manifest -b android10-release;
    cp ${AOSP_RISCV_PATCH_TOP}/manifest/default.xml ${AOSP_RISCV_BUILD_TOP}/.repo/manifests/default.xml
    repo sync
    cd ${AOSP_RISCV_TOP}
    touch ${AOSP_RISCV_TOP}/stages/.stamp_repo_sync
fi

#patch aosp
if [ ! -f ${AOSP_RISCV_TOP}/stages/.stamp_aosp_patch ]; then
    ${AOSP_RISCV_TOP}/script/patch.sh
    touch ${AOSP_RISCV_TOP}/stages/.stamp_aosp_patch
fi

#build aosp
if [ ! -f ${AOSP_RISCV_TOP}/stages/.stamp_aosp_build ]; then
    cd ${AOSP_RISCV_BUILD_TOP}
    source ./build/envsetup.sh
    lunch aosp_riscv64-eng
    export LD_LIBRARY_PATH="${AOSP_RISCV_BUILD_TOP}/out/soong/host/linux-x86/lib64:${AOSP_RISCV_BUILD_TOP}/prebuilts/build-tools/linux-x86/lib64:${AOSP_RISCV_BUILD_TOP}/prebuilts/clang/host/linux-x86/clang-dev/lib64:${AOSP_RISCV_BUILD_TOP}/out/soong/host/linux-x86/lib:/${AOSP_RISCV_BUILD_TOP}/out/host/linux-x86/lib64:${AOSP_RISCV_BUILD_TOP}/prebuilts/clang/host/linux-x86/clang-dev/lib64/"
    m -j 10
    cp ${AOSP_RISCV_BUILD_TOP}/out/target/product/generic_riscv64/system/lib64/vndk-sp-29/libcompiler_rt.so ${AOSP_RISCV_BUILD_TOP}/out/target/product/generic_riscv64/system/lib64/libcompiler_rt.so
    make snod
    cd ${AOSP_RISCV_TOP}/
    touch ${AOSP_RISCV_TOP}/stages/.stamp_aosp_build
fi

#run aosp
echo "Start emulator with cmd:"
echo cd {AOSP_RISCV_BUILD_TOP}
echo "source ./build/envsetup.sh"
echo "lunch aosp_riscv64-eng"
echo "emulator -selinux permissive -qemu -smp 2 -m 3800M -bios ${AOSP_RISCV_BUILD_TOP}/prebuilts/qemu-kernel/riscv64/ranchu/fw_jump.bin"
