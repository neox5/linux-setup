CHROMIUM_VERSION="121.0.6167.139-1"
ARCH="x86_64"
BASE_URL="https://github.com/ungoogled-software/ungoogled-chromium-archlinux/releases/download"
PACKAGE_URL="${BASE_URL}/${CHROMIUM_VERSION}/ungoogled-chromium-${CHROMIUM_VERSION}-${ARCH}.pkg.tar.zst"
OUTPUT_PATH="/tmp/ungoogled-chromium-${CHROMIUM_VERSION}-${ARCH}.pkg.tar.zst"
echo "Installing ungoogled-chromium version ${CHROMIUM_VERSION}"
curl -L $PACKAGE_URL -o $OUTPUT_PATH
echo "downloaded ${OUTPUT_PATH}"
pacman -U --noconfirm $OUTPUT_PATH
# rm $OUTPUT_PATH
