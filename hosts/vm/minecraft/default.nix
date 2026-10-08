{
  ...
}:

{
  imports = [
    ./hardware.nix
    ./firewall.nix
    ./minecraft-server.nix
  ];

  networking = {
    hostName = "minecraft";
  };

  services.qemuGuest.enable = true;
}
