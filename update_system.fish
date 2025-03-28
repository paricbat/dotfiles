#!/usr/bin/fish

rpm-ostree upgrade
flatpak update -y

distrobox enter fedora-dbox -- deno upgrade
distrobox enter fedora-dbox -- sudo dnf update -y
distrobox enter fedora-dbox -- rustup update stable
