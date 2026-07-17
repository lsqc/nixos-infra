{
  ...
}:

{
  imports = [
    ./hardware.nix
    ./netbox.nix
  ];

  networking = {
    hostName = "netbox";
  };
}
