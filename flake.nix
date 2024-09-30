{
  description = "config for autumn's systems";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nix-index-database, nix-vscode-extensions, agenix, hyprland, ... }:
    let
      mkSystem = system: name: hardware: let 
        pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
        unstable = import nixpkgs-unstable { inherit system; config = { allowUnfree = true; }; };
        style = import ./style/default.nix { inherit pkgs; };
        nixosConfig = ./. + "/hosts/${name}";
        hmConfig = ./. + "/hm/${name}.nix";
      in
        nixpkgs.lib.nixosSystem rec {
          specialArgs = { inherit inputs unstable style hyprland; };
          modules = [
            nixosConfig
            hardware
            nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            {
              environment.systemPackages = [
                agenix.packages.${system}.default
              ];
            }
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.autumn.imports = [
                hmConfig
                inputs.nix-index-database.hmModules.nix-index
                inputs.ironbar.homeManagerModules.default
              ];
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x84_64-linux.nixpkgs-fmt;
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        cedar = mkSystem "x86_64-linux" "cedar" nixos-hardware.nixosModules.framework-13th-gen-intel;
        juniper = mkSystem "aarch64-linux" "juniper" nixos-hardware.nixosModules.raspberry-pi-4;
        birch = mkSystem "x86_64-linux" "birch" nixos-hardware.nixosModules.lenovo-thinkpad-t440p;
      };
    };
}
