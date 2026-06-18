# nix

flake providing the configurations for my personal infrastructure

## Remote install

- `nixos-anywhere --flake .#<host> root@<ip> --generate-hardware-config nixos-generate-config ./hosts/<type>/<host>/hardware-configuration.nix --phases disko,install` -> shamelessly stolen from https://git.heroin.trade/xqtc/ryuko-nix 

---

## Remote rebuild

- `nixos-rebuild switch --flake .#<host> --target-host root@<ip> --build-host root@<ip>`
---

## live ISO

- configuration: `hosts/live/iso`
- latest pre-built file: https://files.nya.vodka/pub/nix/iso/latest.iso
- build: `nix build .#nixosConfigurations.live.config.system.build.isoImage` *or* `nix run .#buildIso`

## LXC template

- configuration: `hosts/live/lxc`
- latest pre-built file: https://files.nya.vodka/pub/nix/lxc-template/latest.tar.xz
- build: `nixos-rebuild build-image --image-variant proxmox-lxc --flake .#lxcTemplate`
