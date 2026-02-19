{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
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
          ./configuration.nix
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
