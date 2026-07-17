{ lib, ... }:

{

  imports = [
    ./ssh.nix
    ./users.nix
    ./packages.nix
    ./dns.nix
    ./gc.nix
    ./secrets.nix
  ];

  # enable flakes and new cli
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # timezone
  time.timeZone = "Europe/Berlin";

  # language
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {

    # set helix as default editor because who the fuck uses nano
    variables = {
      EDITOR = "hx";
    };

    # aliases
    shellAliases = {
      vim = "hx";
      vi = "hx";
      nvim = "hx";
      ls = "ls -lsah";
      ll = "ls -l";
      la = "ls -a";
      cat = "bat";
    };
  };

  networking.firewall = {
    enable = lib.mkDefault true;
    allowedTCPPorts = lib.mkDefault [ 22 ];
  };
  system.stateVersion = "26.05";
}
