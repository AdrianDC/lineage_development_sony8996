# WiFi configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/fstman.ini:system/etc/wifi/fstman.ini

# WPA supplicant configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

# WiFi properties
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0
