# Bluetooth configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Bluetooth properties
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.bluetooth.soc=rome \
    ro.bt.bdaddr_path="/data/misc/bdaddr" \
    ro.qualcomm.bt.hci_transport=smd
