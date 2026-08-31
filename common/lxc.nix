{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")

    ./default.nix
    ./prometheus-exporter.nix
  ];

  nix.settings = {
    sandbox = false;
  };

  proxmoxLXC = {
    manageNetwork = false;
    privileged = false;
  };

  networking.interfaces = {
    eth0 = {
      useDHCP = true;
      ipv6.addresses = [
        {
          address = "fd00:420:1:404::1";
          prefixLength = 64;
        }
      ];
    };
  };
}
