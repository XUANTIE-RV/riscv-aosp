TARGET_PREBUILT_KERNEL := device/thead/thead_ice910/kernel/kernel-ice910
TARGET_PREBUILT_DTB := device/thead/thead_ice910/kernel/ice_evb_c910.dtb

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, device/thead/thead_ice910/ice910/device-ice910.mk)
$(call inherit-product, device/thead/thead_ice910/device-common.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Emulator for vendor
#$(call inherit-product-if-exists, device/generic/goldfish/riscv64-vendor.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/product/emulator_vendor.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/board/generic_riscv64/device.mk)

#$(call inherit-product, device/thead/thead_ice910/ice910_vendor.mk)

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += \
					       root/init.zygote32_64.rc \
					       root/init.zygote64_32.rc \


PRODUCT_COPY_FILES += \
		      system/core/rootdir/init.zygote32_64.rc:root/init.zygote32_64.rc

PRODUCT_NAME := ice910
PRODUCT_DEVICE := ice910
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on XuanTie910(RISCV64)
