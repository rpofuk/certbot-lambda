#!/bin/bash

set -e

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CERTBOT_VERSION=$( awk -F= '$1 == "certbot"{ print $NF; }' "${SCRIPT_DIR}/requirements.txt" )
readonly VENV="certbot/venv"
readonly PYTHON="python3.8"
readonly CERTBOT_ZIP_FILE="certbot-${CERTBOT_VERSION}.zip"
readonly CERTBOT_SITE_PACKAGES=${VENV}/lib/${PYTHON}/site-packages

cd "${SCRIPT_DIR}"

${PYTHON} -m venv "${VENV}"
source "${VENV}/bin/activate"

pip3 install -r requirements.txt


rm -rf python
mkdir python
cp -r ${VENV}/* python/

ls -la python
rm -rf ${SCRIPT_DIR}/certbot/${CERTBOT_ZIP_FILE}

zip -r ${SCRIPT_DIR}/certbot/${CERTBOT_ZIP_FILE} python

