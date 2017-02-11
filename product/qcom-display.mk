# Graphics permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:system/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml

# Display QCOM packages
PRODUCT_PACKAGES += \
    copybit.msm8996 \
    gralloc.msm8996 \
    hdmi_cec.msm8996 \
    hwcomposer.msm8996 \
    memtrack.msm8996

# OpenGL properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196610
