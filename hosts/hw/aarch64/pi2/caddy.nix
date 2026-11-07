{ config, ... }:

{
  services.caddy = {
    email = "abuse@nya.vodka";
    enable = true;
    virtualHosts = {
      "${config.services.forgejo.settings.server.DOMAIN}" = {
        extraConfig = ''
          tls internal
          reverse_proxy [::1]:${toString config.services.forgejo.settings.server.HTTP_PORT}

          handle /assets/img/logo.svg {
            root * ${../../../../assets} # logo source: https://commons.wikimedia.org/wiki/File:Spaceglenda.svg, licensed under Creative Commons Attribution-Share Alike 4.0 Internationa
            rewrite * /glenda.svg
            file_server
          }
        '';
      };
    };
  };
}
