{
  description = "My nixOS and nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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

    # my stuff
    dwl.url = "path:/home/benjamin/nix-dotfiles/hosts/desktop/suckless/dwl";
    slstatus.url = "path:/home/benjamin/nix-dotfiles/hosts/desktop/suckless/slstatus";
  };

  outputs = inputs @ {
    nixpkgs,
    nix-darwin,
    nix-flatpak,
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
              nix-flatpak.homeManagerModules.nix-flatpak
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
