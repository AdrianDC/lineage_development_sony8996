# Fingerprint permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml

# Fingerprint package
PRODUCT_PACKAGES += \
    fingerprintd
