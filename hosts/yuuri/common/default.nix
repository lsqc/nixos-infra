{ ... }:

{
  imports = [
    ./networking.nix
    ../../../common/lxc.nix
  ];

  system.stateVersion = "26.05";
}
