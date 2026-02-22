{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Deltatune
    deltatune.url = "github:jesperls/deltatune-linux"; # Thanks Jesper

    # Cursor
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "nixpkgs";
    };

    # Solar but actually updated to the latest version unlike the nixpkg
    solaar = {
      # url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.7.tar.gz"; # uncomment line for solaar version 1.1.19
      # url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # myna = {
    #   url = "path:/home/smoxboye/programming/myna";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   # inputs.quickshell.follows = "quickshell"; # or add quickshell to your inputs if not already
    # };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      solaar,
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
          solaar.nixosModules.default
        ];
      };
    };
}
