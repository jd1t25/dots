#!/bin/bash
# Author : Ruturajn <nanotiruturaj@gmail.com>

# This script builds a package in a clean chroot, within
# a containerized environment. Run this script from the directory,
# containing the PKGBUILD.

# Define the CHROOT variable
CHROOT="${HOME}"/Documents/chroot
if [[ ! -d "${CHROOT}" ]] ; then
    mkdir -p "${CHROOT}"
fi

# Check if $CHROOT/root doesn't exist
if [[ ! -d "${CHROOT}"/root ]] ; then
    mkarchroot "${CHROOT}"/root base-devel
fi

# Update the CHROOT environment
arch-nspawn "${CHROOT}"/root pacman -Syu

# Build the package
makechrootpkg -c -r "${CHROOT}"

