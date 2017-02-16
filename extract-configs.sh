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
else
    if [ $# -eq 1 ]; then
        SRC=$1
    else
        echo "$0: bad number of arguments"
        echo ""
        echo "usage: $0 [PATH_TO_EXPANDED_ROM]"
        echo ""
        echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
        echo "the device using adb pull."
        exit 1
    fi
fi

#
# extract_configs:
#
# $1: file containing the list of items to extract
# $2: path to device folder containing the build files
# $3: path to extracted system folder, or "adb" to extract from device
#
function extract_configs() {
    parse_file_list "$1"

    # Allow failing, so we can try $DEST and/or $FILE
    set +e

    local FILELIST=( ${PRODUCT_COPY_FILES_LIST[@]} ${PRODUCT_PACKAGES_LIST[@]} )
    local HASHLIST=( ${PRODUCT_COPY_FILES_HASHES[@]} ${PRODUCT_PACKAGES_HASHES[@]} )
    local COUNT=${#FILELIST[@]}
    local OUTPUT_DIR="$2"
    local SRC="$3"

    if [ "$SRC" = "adb" ]; then
        init_adb_connection
    fi

    echo "Extracting $COUNT files in $1 from $SRC:"

    for (( i=1; i<COUNT+1; i++ )); do

        local SPLIT=(${FILELIST[$i-1]//:/ })
        local FILE="system/${SPLIT[0]#-}"
        local DEST="$OUTPUT_DIR/${SPLIT[1]#-}"

        if [ "$SRC" = "adb" ]; then
            printf '  - %s .. ' "/$FILE"
        else
            printf '  - %s \n' "/$FILE"
        fi

        if [ "$SRC" = "adb" ]; then
            # Try file target
            adb pull "/$FILE" "$DEST"
        else
            # Try file target
            if [ -f "$SRC/$FILE" ]; then
                cp "$SRC/$FILE" "$DEST"
            else
                printf '    !! file not found in source\n'
            fi
        fi

        if [ -f "$DEST" ]; then
            chmod 644 "$DEST"
        fi

    done

    # Don't allow failing
    set -e
}

# Initialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$ROM_ROOT"

# Initialize adb connection
if [ "$SRC" = "adb" ]; then
    init_adb_connection
fi

# Sony/Device specific configs
extract_configs "$MY_DIR"/proprietary-configs.txt "$MY_DIR" "$SRC"
