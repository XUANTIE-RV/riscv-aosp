#include device/thead/thead_ice910/vivante-gpu/Android.mk
USE_XML_AUDIO_POLICY_CONF := 1

# Graphics HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl

# ConfigStore which should be replaced by system property
PRODUCT_PACKAGES += \
    android.hardware.configstore-utils \
    android.hardware.configstore@1.0-service \
    android.hardware.configstore@1.0 \
    android.hardware.configstore@1.1

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-service \
    android.hardware.audio@5.0-impl:32 \
    android.hardware.audio.effect@5.0-impl:32 \
    android.hardware.soundtrigger@2.2-impl:32

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

DEVICE_MANIFEST_FILE := \
    device/thead/thead_ice910/manifest.xml
