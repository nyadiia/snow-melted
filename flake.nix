{
  description = "config for nadia's systems";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    systems.url = "github:nix-systems/default";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    matugen.url = "github:InioX/Matugen";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-hardware,
      nix-index-database,
      nix-vscode-extensions,
      matugen,
      systems,
      ...
    }:

    let
      eachSystem =
        function: nixpkgs.lib.genAttrs (import systems) (system: function nixpkgs.legacyPackages.${system});

      mkSystem = 
      { system ? "x86_64-linux", name, hardware ? "" }:
      let 
        config = {
          allowUnfree = true;
        };
        pkgs = import nixpkgs { inherit system config; };
        style = import ./style { inherit pkgs; };
        nixosConfig = ./. + "/hosts/${name}";
        hmConfig = ./. + "/hm/${name}.nix";

        specialArgs = { inherit inputs unstable style; };
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./modules/common.nix
            nixosConfig
            hardware
            nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nyadiia.imports = [
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x84_64-linux.nixfmt-rfc-style;
      nixosConfigurations = {
        hyprdash = mkSystem { "x86_64-linux" "cedar" nixos-hardware.nixosModules.framework-11th-gen-intel };
      };
      packages = eachSystem (pkgs: {
        nvim = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
          inherit pkgs;
          module = import ./packages/nixvim.nix;
        };
      });
    };
}
