{
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./net.nix
    ./hw.nix
  ];
}
