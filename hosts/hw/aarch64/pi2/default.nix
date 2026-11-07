{ pkgs, config, ... }:

{
  imports = [
    ./hardware.nix
    ../../../../common

    ./net.nix
    ./forgejo.nix
    ./caddy.nix
  ];

  system.stateVersion = config.system.nixos.release;

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  environment.systemPackages = [ pkgs.wireguard-tools ];

  users.users.lsqc.shell = pkgs.nushell;
}
