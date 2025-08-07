#!/usr/bin/env nu
do -c {
  buildah build --pull=newer -t fedora-dbox-image .
  distrobox assemble create --replace ./fedora-dbox.ini
}
