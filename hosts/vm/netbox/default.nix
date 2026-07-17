{
  ...
}:

{
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  networking = {
    hostName = "netbox";
  };
}
