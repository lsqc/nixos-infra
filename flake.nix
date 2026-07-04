{
  description = "infra flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    kirikae.url = "git+https://git.sr.ht/~xqtc/kirikae";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      agenix,
      disko,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; };
      config = import ./common/config.nix;

      commonModules = [
        agenix.nixosModules.default
        disko.nixosModules.disko
      ];
    in
    {
      nixosConfigurations = {

        #
        # Configurations for vms and lxcs
        #
        dns1 = nixpkgs.lib.nixosSystem {
          inherit system; # system = "x86_64-linux";

          modules = commonModules ++ [ ./hosts/lxc/dns/dns1 ];
        };

        dns2 = nixpkgs.lib.nixosSystem {
          inherit system; # system = "x86_64-linux";

          modules = commonModules ++ [ ./hosts/lxc/dns/dns2 ];
        };

        dns3 = nixpkgs.lib.nixosSystem {
          inherit system; # system = "x86_64-linux";

          modules = commonModules ++ [ ./hosts/lxc/dns/dns3 ];
        };

        postgres-1 = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [ ./hosts/lxc/db/postgres-1 ];
        };

        paperless = nixpkgs.lib.nixosSystem {

          inherit system;
          modules = commonModules ++ [ ./hosts/lxc/paperless ];
        };

        hydra = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/vm/hydra/disko-config.nix
            ./hosts/vm/hydra
          ];
        };

        torrent = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/vm/torrent
            ./hosts/vm/torrent/disko-config.nix
          ];
        };

        hachi = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/vm/hachi
            ./hosts/vm/hachi/disko-config.nix
          ];
        };

        prometheus = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/vm/prometheus
            ./hosts/vm/prometheus/disko-config.nix
          ];
        };

        ash = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/vm/ash
            ./hosts/vm/ash/disko-config.nix
          ];
        };
        #
        # Configurations for non-virtualized systems
        #

        gemini = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/hw/x86_64/gemini
          ];
        };

        testbox = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/hw/x86_64/testbox
            ./hosts/hw/x86_64/testbox/disko-config.nix
          ];
        };

        cheese = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = commonModules ++ [

            ./hosts/hw/x86_64/cheese
          ];
        };

        # aarch64 systems
        pi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";

          modules = [
            agenix.nixosModules.default
            ./hosts/hw/aarch64/pi
          ];
        };

        #
        # Configuration for the custom live cd
        #
        liveIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")

            ./hosts/live/iso
          ];
        };

        lxc-template = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/live/lxc
            agenix.nixosModules.default
          ];
        };
      };

      kirikae = {
        hosts = {
          prometheus = {
            targetHost = "${config.mkLabFQDN "prometheus"}";
            targetUser = "root";
          };
        };
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        shellHook = "${lib.getExe pkgs.nushell}";
        nativeBuildInputs = [
          inputs.kirikae.packages.x86_64-linux.default
          pkgs.just
        ];
      };
    };
}
