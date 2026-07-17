{ config, ... }:

{
  services.transmission = {
    enable = true;

    settings = {
      rpc-bind-address = "127.0.0.1";
      download-dir = "/mnt/torrents";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-9.15.9"
  ];

  systemd.services.flood.serviceConfig.SupplementaryGroups = [ config.services.transmission.group ];
}
