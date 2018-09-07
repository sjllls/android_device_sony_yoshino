#!/vendor/bin/sh

ORIGINAL_OEM_DIR="/oem-modem"
TMP_OEM_DIR="/tmp/oem"

CUSTOMIZATION_SELECTOR_OVERLAY="${ORIGINAL_OEM_DIR}/overlay/com.sonymobile.customizationselector-res-305.apk"

### Check if a customization is active
ACTIVE_CUSTOMIZATION="$(/vendor/bin/getprop ro.semc.version.cust.active)"

if [ -n "${ACTIVE_CUSTOMIZATION}" ]; then
    CARRIER_CONFIG_OVERLAY="${ORIGINAL_OEM_DIR}/overlay-${ACTIVE_CUSTOMIZATION}/com.android.carrierconfig-res-310-${ACTIVE_CUSTOMIZATION}.apk"
else
    CARRIER_CONFIG_OVERLAY="${ORIGINAL_OEM_DIR}/overlay/com.android.carrierconfig-res-305.apk"
fi

### Create /oem/overlay and copy the overlays there
mkdir "${TMP_OEM_DIR}/overlay"
chmod 0755 "${TMP_OEM_DIR}/overlay"
cp -p ${CUSTOMIZATION_SELECTOR_OVERLAY} ${TMP_OEM_DIR}/overlay/
cp -p ${CARRIER_CONFIG_OVERLAY} ${TMP_OEM_DIR}/overlay/

### Fix selinux contexts (need to change context of files seperatly, since /vendor/overlay is symlinked)
chcon -R u:object_r:vendor_overlay_file:s0 ${TMP_OEM_DIR}/overlay/
restorecon -R /vendor/overlay

### Done
exit 0
