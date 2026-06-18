hostname := `hostname`
user := `whoami`

default:
    @just --choose

system-rebuild:
    sudo nixos-rebuild switch --flake .#{{hostname}}

build-lxc-template:
    nixos-rebuild build-image --image-variant proxmox-lxc --flake .#lxc-template

build-iso:
    nixos-rebuild build-image --image-variant iso --flake .#liveIso
