#
# Copyright (C) 2017 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#mj-debug: don't need
#include build/make/target/board/BoardConfigGsiCommon.mk

TARGET_ARCH := riscv64
TARGET_ARCH_VARIANT := riscv64
TARGET_CPU_ABI := riscv64
#TARGET_CPU_ABI := lp64d
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic


TARGET_USERIMAGES_USE_EXT4 := true
# FIXME: there are have 2ND arch, may riscv32, skip here
#TARGET_2ND_ARCH := riscv64
#TARGET_2ND_ARCH_VARIANT := riscv64
#TARGET_2ND_CPU_ABI := lp64d
#TARGET_2ND_CPU_ABI2 := riscv64
#TARGET_2ND_CPU_VARIANT := generic

# TODO(jiyong) These might be SoC specific.
#BOARD_ROOT_EXTRA_FOLDERS += firmware firmware/radio persist
#BOARD_ROOT_EXTRA_SYMLINKS += /vendor/lib/dsp:/dsp
#BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware_mnt/image:/firmware/image
#BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware_mnt/verinfo:/firmware/verinfo

# TODO(b/36764215): remove this setting when the generic system image
# no longer has QCOM-specific directories under /.
BOARD_SEPOLICY_DIRS += build/target/board/generic_riscv64_ab/sepolicy

#Set system property
TARGET_SYSTEM_PROP += device/thead/thead_ice910/ice910/system.prop
