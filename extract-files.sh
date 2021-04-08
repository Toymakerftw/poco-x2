#!/bin/bash
#
# Copyright (C) 2020-2021 Wave-OS
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib64/hw/camera.qcom.so)
            "${PATCHELF}" --remove-needed "libMegviiFacepp-0.5.2.so" "${2}"
            "${PATCHELF}" --remove-needed "libmegface.so" "${2}"
            "${PATCHELF}" --add-needed "libshim_megvii.so" "${2}"
            ;;
        vendor/lib64/libgoodixhwfingerprint.so )
        "${PATCHELF}" --remove-needed "android.hidl.base@1.0.so" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=phoenix
export DEVICE_COMMON=sm6150-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
