#!/usr/bin/env bash

set -euxo pipefail

if [[ ! -v REMOTE ]]; then
  dst=$1
  ssh "${dst}" REMOTE=1 bash -s <"$0"
  exit
fi

VMID=9000
DEBIAN_IMAGE=debian-13-genericcloud-amd64.qcow2
DEBIAN_IMAGE_URL=https://cdimage.debian.org/images/cloud/trixie/latest/${DEBIAN_IMAGE}
DEBIAN_IMAGE_PATH=/tmp/${DEBIAN_IMAGE}
DEBIAN_IMAGE_CUSTOMIZED=debian-13-genericcloud-amd64-customized.qcow2
DEBIAN_IMAGE_CUSTOMIZED_PATH=/tmp/${DEBIAN_IMAGE_CUSTOMIZED}

# Fail fast if the VMID already exists
qm create "${VMID}" --name bootstrap --scsihw virtio-scsi-pci --net0 virtio,bridge=vmbr0

# Avoid downloading the image repeatedly
if [[ ! -e ${DEBIAN_IMAGE_PATH} ]]; then
  wget "${DEBIAN_IMAGE_URL}" -O "${DEBIAN_IMAGE_PATH}"
fi

apt-get install --yes --autoremove libguestfs-tools
# Start from scratch every time
cp "${DEBIAN_IMAGE_PATH}" "${DEBIAN_IMAGE_CUSTOMIZED_PATH}"
virt-customize \
  --add "${DEBIAN_IMAGE_CUSTOMIZED_PATH}" \
  --install qemu-guest-agent \
  --truncate /etc/machine-id

qm set "${VMID}" --scsi0 local-lvm:0,import-from="${DEBIAN_IMAGE_CUSTOMIZED_PATH}"
qm set "${VMID}" --cdrom local-lvm:cloudinit
qm set "${VMID}" --boot order=scsi0
qm set "${VMID}" --agent enabled=1

qm template "${VMID}"
