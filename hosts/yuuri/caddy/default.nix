{
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ./caddy.nix
  ];

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];

  systemd.network = {

    enable = true;

    networks."10-eth" = {
      address = [ "2a01:4f8:13a:f801::6d" ];
    };
  };
}
