{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let myUtil = import ./myUtil/default.nix { inherit inputs; };
    in with myUtil; {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        laptop = mkSystem ./hosts/laptop/configuration.nix;
      };

      homeConfigurations = {
        # ================ Maintained home configurations ================ #

        "agnes@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
      };

      homeManagerModules.default = ./modules/home;
      nixosModules.default = ./modules/nixos;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
