#!/bin/sh

DIR="$(dirname "$0")"

# Files
XSETUP="/usr/share/sddm/scripts/Xsetup"
SDDM_CONF="/etc/sddm.conf"

# LOGIN CONFIGURATION
# -------------------
# XSetup
mv ${XSETUP} ${XSETUP}_bak # backup Xsetup
cp "${DIR}/desktop/sddm/Xsetup" ${XSETUP}
# sddm.conf
mv $SDDM_CONF ${SDDM_CONF}_bak # backup sddm.conf
echo -e "# Xsetup script for multi monitor setup\n" >> $SDDM_CONF
echo -e "[XDisplay]\nDisplayCommand=/usr/share/sddm/scripts/Xsetup\n" >> $SDDM_CONF
