{ ... }:

{
  services.forgejo = {
    enable = true;
    settings = {
      server = rec {
        DOMAIN = "git.nya.vodka";
        ROOT_URL = "https://${DOMAIN}";
      };
    };
  };
}
