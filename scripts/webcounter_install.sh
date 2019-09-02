#!/usr/bin/env bash
# Install the latest version of webcounter as service

# If WC_VER is not set default to the latest release
[ ${WC_VER} ] && {
    export WC_RELEASE_URL="https://api.github.com/repos/slavrd/go-redis-counter/releases/tags/v${WC_VER}"
} || {
    export WC_RELEASE_URL="https://api.github.com/repos/slavrd/go-redis-counter/releases/latest"
}

WC_FILE="webcounter.zip"

# check if prerequisite packages are installed
PKGS="jq curl unzip"
which ${PKGS} >>/dev/null || {
    sudo apt-get update
    sudo apt-get install -y ${PKGS}
}

# Donwlaod the latest release
URL=$(curl -sS ${WC_RELEASE_URL} | jq -r ".assets[] | select( .name == \"${WC_FILE}\" ).browser_download_url")

curl -sSfL -o "/tmp/$WC_FILE" ${URL} || {
    echo "download failed"
    exit 1
}

pushd /opt/ >>/dev/null
sudo unzip -o "/tmp/$WC_FILE" || {
    echo "error extracting archive"
    exit 1
}
popd >>/dev/null

rm -f "/tmp/$WC_FILE"
