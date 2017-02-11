# Camera configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera/camera_config.xml:system/etc/camera/camera_config.xml

# Camera packages
PRODUCT_PACKAGES += \
    Snap

# Camera properties
PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1
