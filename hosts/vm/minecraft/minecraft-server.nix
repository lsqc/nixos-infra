{ inputs, pkgs, ... }:

{
  imports = [ inputs.nix-minecraft-folia.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft-folia.overlays.default ];

  services.minecraft-servers =
    with pkgs;
    let
      folia-executable = fetchurl {
        url = "https://fill-data.papermc.io/v1/objects/128a634192261cd38bb4a5dc54075018a0f896fd6c6f529e37dca6e99e32b3b3/folia-26.2-7.jar";
        sha256 = "128a634192261cd38bb4a5dc54075018a0f896fd6c6f529e37dca6e99e32b3b3";
      };
      folia-package = writeShellScriptBin "minecraft-server" ''
        exec ${jdk25_headless}/bin/java "$@" -jar ${folia-executable} nogui
      '';
    in
    {
      enable = true;
      eula = true;
      openFirewall = true;

      servers.folia = {
        enable = true;
        package = folia-package;
        jvmOpts = "-Xmx100G -Xms8G";
        serverProperties = {
          motd = "hululu";
          max-players = 100;
          view-distance = 20;
        };
      };
    };
}
