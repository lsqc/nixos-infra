{ lib, pkgs, ... }:

let
  config = import ../../../common/config.nix;
in
{

  services.bind = {
    enable = true;

    cacheNetworks = [
      "127.0.0.0/8"
      "10.42.0.0/16"
    ];

    forward = "only";
    forwarders = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    zones = {
      "${config.domains.lab}" = {
        master = true;
        slaves = [
          "10.42.0.6"
          "10.42.0.7 "
        ];
        file =
          let
            zoneTemplate = ../../../dns/lab.ip.nya.vodka.zone;
            serialTimestamp = lib.strings.trim (
              builtins.readFile (
                pkgs.runCommand "zone-serial" { } ''
                  date +%s > $out
                ''
              )
            );

            content = builtins.readFile zoneTemplate;
            updatedZone = builtins.replaceStrings [ "serial-number" ] [ serialTimestamp ] content;

            finalZone = updatedZone + "\n";

          in
          pkgs.writeText "${config.domains.lab}" finalZone;
      };
    };
    extraOptions = ''
      recursion yes;
      allow-recursion { any; };

      # forward only;
      # forwarders {
      #   1.1.1.1;
      #   9.9.9.9;
      # };

      dnssec-validation auto;
      listen-on { any; };
      listen-on-v6 { any; };
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [
      22
      53
    ];
    allowedUDPPorts = [ 53 ];
  };
}
