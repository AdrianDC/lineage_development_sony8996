#!/bin/bash
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

set -e

# Required!
export DEVICE=dora
export VENDOR=sony

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ROM_ROOT="$MY_DIR"/../../..

HELPER="$ROM_ROOT"/vendor/cm/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

if [ $# -eq 0 ]; then
    SRC=adb
    SRC_SECONDARY=adb
else
    if [ $# -eq 1 ]; then
        SRC=$1
        SRC_SECONDARY=$1
    else
        if [ $# -eq 2 ]; then
            SRC=$1
            SRC_SECONDARY=$2
        else
            echo "$0: bad number of arguments"
            echo ""
            echo "usage: $0 [PATH_TO_EXPANDED_ROM] [PATH_TO_UPDATED_VENDOR_OR_SYSTEM_PROPRIETARY]"
            echo ""
            echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
            echo "the device using adb pull."
            echo ""
            echo "If PATH_TO_UPDATED_VENDOR_OR_SYSTEM_PROPRIETARY is also defined, some blobs"
            echo "that require updated origins will be retrieved from another vendor path."
            exit 1
        fi
    fi
fi

# Handle secondary path
SRC_SECONDARY_LINKED=
if [ ! "$SRC" = 'adb' ] && [ ! "$SRC" = "$SRC_SECONDARY" ]; then
    if [ -d "$SRC_SECONDARY/proprietary" ] && [ ! -e "$SRC_SECONDARY/system" ]; then
        ln -s "$SRC_SECONDARY/proprietary" "$SRC_SECONDARY/system"
        SRC_SECONDARY_LINKED=true
    fi
fi

# Initialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$ROM_ROOT"

# Sony/Device specific blobs
extract "$MY_DIR"/proprietary-files-sony.txt "$SRC"

# QCom common blobs
extract "$MY_DIR"/proprietary-files-qc.txt "$SRC"

# QCom graphics blobs
extract "$MY_DIR"/proprietary-files-qc-graphics.txt "$SRC_SECONDARY"

# Generate vendor makefiles
"$MY_DIR"/setup-makefiles.sh

# Cleanup secondary path
if [ ! -z "$SRC_SECONDARY_LINKED" ]; then
    rm "$SRC_SECONDARY/system"
fi
