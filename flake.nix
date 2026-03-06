{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      helium,
      catppuccin,
      ...
    }@inputs:
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.omrih = {
                imports = [
                  ./home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };

      nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/pc/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.omrih = {
                imports = [
                  ./home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    };
}
