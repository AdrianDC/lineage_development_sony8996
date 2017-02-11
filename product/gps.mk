# GPS configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/configs/gps/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/configs/gps/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/configs/gps/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/configs/gps/lowi.conf:system/etc/lowi.conf \
    $(LOCAL_PATH)/configs/gps/sap.conf:system/etc/sap.conf \
    $(LOCAL_PATH)/configs/gps/xtwifi.conf:system/etc/xtwifi.conf

# GPS properties
PRODUCT_PROPERTY_OVERRIDES += \
    persist.gps.qc_nlp_in_use=1 \
    ro.gps.agps_provider=1
