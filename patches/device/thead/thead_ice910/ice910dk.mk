TARGET_PREBUILT_KERNEL := device/thead/thead_ice910/kernel/kernel-ice910
TARGET_PREBUILT_DTB := device/thead/thead_ice910/kernel/ice_evb_c910.dtb

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, device/thead/thead_ice910/ice910dk/device-ice910dk.mk)
$(call inherit-product, device/thead/thead_ice910/device-common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

DEVICE_PACKAGE_OVERLAYS := device/thead/thead_ice910/overlay

PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed

PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += \
					       root/init.zygote32_64.rc \
					       root/init.zygote64_32.rc \

PRODUCT_COPY_FILES += \
		      system/core/rootdir/init.zygote32_64.rc:root/init.zygote32_64.rc \

DEVICE_PACKAGE_OVERLAYS := device/thead/thead_ice910/overlay/dk

PRODUCT_NAME := ice910dk
PRODUCT_DEVICE := ice910dk
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP on XuanTie910(RISCV64)
