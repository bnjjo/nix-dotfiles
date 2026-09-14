{
  description = "My nixOS and nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation.url = "github:nix-community/preservation";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nix-darwin,
    disko,
    preservation,
    home-manager,
    fenix,
    ...
  }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs fenix;};
      modules = [
        ./hosts/desktop/configuration.nix
        ./hosts/desktop/disko.nix
        ./hosts/desktop/preservation.nix
        disko.nixosModules.disko
        preservation.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs fenix;};
            users.benjamin.imports = [
              ./hosts/desktop/home.nix
            ];
            backupFileExtension = "backup";
          };
        }
      ];
    };

    darwinConfigurations.nix-darwin = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit inputs fenix;};
      modules = [
        ./hosts/mba/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs fenix;};
            users.benjamin = ./hosts/mba/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
