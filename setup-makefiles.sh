#!/bin/bash
#
# Copyright (C) 2018-2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=sm6125-common
VENDOR=xiaomi
INITIAL_COPYRIGHT_YEAR=2019

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

LINEAGE_ROOT="$MY_DIR"/../../..

HELPER="$LINEAGE_ROOT"/vendor/lineage/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper
setup_vendor "$DEVICE" "$VENDOR" "$LINEAGE_ROOT"

# Copyright headers and guards
write_headers

write_makefiles "$MY_DIR"/proprietary-files-common.txt true

cat << EOF >> "${ANDROIDMK}"

\$(shell mkdir -p \$(TARGET_OUT_VENDOR)/lib/egl && pushd \$(TARGET_OUT_VENDOR)/lib > /dev/null && ln -s egl/libGLESv2_adreno.so libGLESv2_adreno.so && popd > /dev/null)

EOF

# Finish
write_footers
