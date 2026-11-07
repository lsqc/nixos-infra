{ ... }:

{
  services.forgejo = {
    enable = true;
    settings = {
      server = {
        DOMAIN = "git.nya.vodka";
      };
    };
  };
}
