AOSP_BUILD_TOP=/home/maoh/aosp
AOSP_PATCH_TOP=/home/maoh/aosp_on_riscv/patches/

apply_patch(){
	echo apply patch for $1
	pushd . >> /dev/null
	cd ${AOSP_RISCV_BUILD_TOP}/$1
	git apply ${AOSP_RISCV_PATCH_TOP}/$1/*.patch
	popd >> /dev/null
}

apply_zip(){
	echo unpack zip for $1
	#rm -rf  $1
	pushd . >> /dev/null
	mkdir -p ${AOSP_RISCV_BUILD_TOP}/$1
	cd ${AOSP_RISCV_BUILD_TOP}/$1
	unzip -q -o ${AOSP_RISCV_PATCH_TOP}/$1/*.zip
	popd >> /dev/null
}

apply_patch art
apply_patch bionic
apply_patch build/make
apply_patch build/soong
apply_patch_diff cts
apply_patch dalvik
apply_patch development
apply_patch device/generic/goldfish
apply_patch external/android-clat
apply_patch external/boringssl
apply_patch external/clang
apply_patch external/compiler-rt
apply_patch external/eigen
apply_patch external/google-benchmark
apply_patch external/libchrome
apply_patch external/libjpeg-turbo
apply_patch external/llvm
apply_patch external/minijail
apply_patch external/pdfium
apply_patch external/perf_data_converter
apply_patch external/protobuf
apply_patch external/strace
apply_patch external/tremolo
apply_patch external/vixl
apply_patch frameworks/av
apply_patch frameworks/base
apply_patch frameworks/native
apply_patch hardware/interfaces
apply_patch hardware/libhardware
apply_patch libcore
apply_patch libnativehelper
apply_patch prebuilts/clang/host/linux-x86
apply_patch prebuilts/ndk
apply_patch prebuilts/vndk/v28
apply_patch prebuilts/vndk/v27
apply_patch system/apex
apply_patch system/core
apply_patch system/extras
apply_patch system/libhidl
apply_patch system/libhwbinder
apply_patch system/vold
apply_patch system/tools/hidl/
apply_patch test/vts
apply_patch test/vts-testcase/fuzz

apply_zip prebuilts/gcc/linux-x86/riscv64/
apply_zip prebuilts/misc
apply_zip prebuilts/ndk
apply_zip prebuilts/qemu-kernel
apply_zip prebuilts/android-emulator
apply_zip prebuilts/clang-tools
apply_zip prebuilts/clang/host/linux-x86
apply_zip prebuilts/vndk/v28
