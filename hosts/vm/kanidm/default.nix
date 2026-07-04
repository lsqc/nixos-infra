{
  ...
}:

{
  imports = [
    ../../../common
    ../../../common/vm.nix
    ../../../common/grub-uefi.nix
    ../../../common/prometheus-exporter.nix

    ./hardware.nix
    ./kanidm.nix
  ];

  networking = {
    hostName = "kanidm";
  };
}
