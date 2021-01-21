PRODUCT_COPY_FILES +=   $(TARGET_PREBUILT_KERNEL):kernel \
                        $(TARGET_PREBUILT_DTB):thead-ice910.dtb

PRODUCT_COPY_FILES +=   device/thead/thead_ice910/ice910/init.ice910.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.ice910.rc \
			device/thead/thead_ice910/ice910/init.common.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.common.usb.rc \
			frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
			device/thead/thead_ice910/ice910/fstab.ice910:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ice910

PRODUCT_COPY_FILES += \
			device/thead/thead_ice910/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
			frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
			frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
			frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
			frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
			frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
			device/thead/thead_ice910/prebuilts/Vendor_0416_Product_1001_Version_0200.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_0416_Product_1001_Version_0200.kl

PRODUCT_COPY_FILES += \
			device/thead/thead_ice910/prebuilts/goodix.ko:$(TARGET_COPY_OUT_VENDOR)/lib64/modules/goodix.ko \
			device/thead/thead_ice910/vivante-gpu/galcore.ko:$(TARGET_COPY_OUT_VENDOR)/lib64/modules/galcore.ko

PRODUCT_COPY_FILES += \
			device/thead/thead_ice910/prebuilts/gralloc.ice910.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/ \
			device/thead/thead_ice910/prebuilts/egl/:$(TARGET_COPY_OUT_VENDOR)/lib64/ \
# ethernet
PRODUCT_COPY_FILES += \
			frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

PRODUCT_PACKAGES += gralloc.ice910 \
		    audio.primary.ice910 \
		    audioserver
