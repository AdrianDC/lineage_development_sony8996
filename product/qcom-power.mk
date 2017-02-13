# Power package
PRODUCT_PACKAGES += \
    power.qcom

# Performance properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.am.reschedule_service=true \
    ro.vendor.extension_library=libqti-perfd-client.so
