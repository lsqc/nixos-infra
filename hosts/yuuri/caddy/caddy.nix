{ ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "git.nya.vodka" = {
        extraConfig = ''
          reverse_proxy http://[2a01:4f8:13a:f801::f30]:5000
        '';
      };
    };
  };
}
