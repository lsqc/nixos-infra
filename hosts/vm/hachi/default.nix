{ ... }:

{
  imports = [
    ./hardware.nix

    ./forgejo.nix
  ];

  networking = {
    hostName = "hachi";

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        3000
      ];
    };
  };
}
