{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Deltatune
    deltatune.url = "github:jesperls/deltatune-linux"; # Thanks Jesper

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.SmoxPC = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/SmoxPC/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.smoxboye = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
