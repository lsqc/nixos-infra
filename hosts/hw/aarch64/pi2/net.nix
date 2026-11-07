{ ... }:

{
  networking = {
    # useDHCP = true;
    hostName = "pi2";

    networkmanager.enable = true;

    firewall = {

      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
    };
  };
}
