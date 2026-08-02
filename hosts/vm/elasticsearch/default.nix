{
  lib,
  ...
}:

{
  imports = [
    ./hardware.nix
    ./elasticsearch.nix
    ./firewall.nix
  ];

  networking = {
    hostName = "elasticsearch";
  };

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "elasticsearch"
      ];
    permittedInsecurePackages = [ "elasticsearch-7.17.27" ];
  };
}
