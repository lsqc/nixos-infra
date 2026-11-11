{ ... }:

{
  systemd.network = {

    enable = true;

    networks."10-eth" = {
      matchConfig.Name = "eth0";
      linkConfig.RequiredForOnline = "routable";

      dns = [
        "2a01:4f8:13a:f801::10"
        "2620:fe::fe"
      ];

      networkConfig = {
        DHCP = "no";
        LinkLocalAddressing = "ipv6";
        IPv6AcceptRA = true;
      };
    };
  };

  services.resolved.enable = true;

}
