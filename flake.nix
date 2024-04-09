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

    # ironbar = {
    #   url = "github:JakeStanger/ironbar";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nix-index-database, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
      unstable = import nixpkgs-unstable { inherit system; config = { allowUnfree = true; }; };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      nixosConfigurations = {
        cedar = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs unstable; };
          modules = [
            ./hosts/cedar
            nixos-hardware.nixosModules.framework-13th-gen-intel
            nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            # inputs.ironbar.homeManagerModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.autumn.imports = [
                ./hm/cedar.nix
                inputs.nix-index-database.hmModules.nix-index
              ];
              home-manager.extraSpecialArgs = { inherit inputs unstable; };
            }
          ];
        };
      };
    };
}
