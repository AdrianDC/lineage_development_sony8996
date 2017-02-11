#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit common Lineage stuff
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configurations
$(call inherit-product, device/sony/dora/device.mk)

# Device display
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Device identifications
PRODUCT_DEVICE := dora
PRODUCT_NAME := lineage_dora
PRODUCT_BRAND := Sony
PRODUCT_MANUFACTURER := Sony
PRODUCT_MODEL := Xperia X Performance
PRODUCT_PLATFORM := tone

# Build fingerprints
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=F8131
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=Sony/dora/dora:7.0/TONE-2.1.0-161121-0615/1:user/dev-keys
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="dora-user 7.0 TONE-2.1.0-161121-0615 1 dev-keys"
