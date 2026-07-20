{ ... }:

{
  imports = [
    ./default.nix
    ./grub-uefi.nix
    ./prometheus-exporter.nix
  ];

  services.qemuGuest.enable = true;

  systemd.network.wait-online.enable = false;
}
