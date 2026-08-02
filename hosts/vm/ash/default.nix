{
  ...
}:

{
  imports = [
    ./hardware.nix

    ./acme.nix
    ./mastodon.nix
    ./networking.nix
  ];

  networking = {
    hostName = "ash";
  };
}
