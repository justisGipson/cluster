#!/bin/bash

# this script 
# - preps pi memory card ( /dev/disk5 )
# - partitions mem card
# - unpacks RPI base system
# - applies headless boot config w/ network interface & ssh agent - accepts conns w/out pass

PI_CARD="/dev/disk5"
ALPINE_BASE_IMAGE="https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/aarch64/alpine-rpi-3.13.2-aarch64.tar.gz"
# [[ -f /Volumes/RPI0 ]] && echo "Deleting leftover directory"; rm -fr /Volumes/RPI0 || echo "Clean and dandy on the Volumes front"
[[ ! -f static/alpine-aarch64.tar.gz ]] && wget $ALPINE_BASE_IMAGE -O static/alpine-aarch64.tar.gz || echo "Alpine baseimg already exists"
sudo diskutil eraseDisk FAT32 RPI MBRFormat $PI_CARD
sudo diskutil partitionDisk /dev/$PI_CARD MBRFormat FAT32 RPI0 1g FREE RPISYS 0b
sudo tar xf static/alpine-aarch64.tar.gz -C /Volumes/RPI0
sudo cp static/headless.tar.gz /Volumes/RPI0/headless.apkovl.tar.gz
