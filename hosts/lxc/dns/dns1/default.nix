{ ... }:

{
  imports = [

    ../../../../common/lxc.nix

    ./bind.nix
    ../bind-common.nix
    ../prometheus.nix
  ];

  networking.interfaces = {
    eth0 = {
      ipv6.addresses = [
        {
          address = "fd00:420:1:d::4";
          prefixLength = 64;
        }
      ];
    };
  };
}
