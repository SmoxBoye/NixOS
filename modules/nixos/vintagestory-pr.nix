{ pkgs, inputs, ... }:

let
  # Instantiate the package set from the PR input defined in flake.nix
  prPkgs = import inputs.nixpkgs-vs {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = [
    prPkgs.vintagestory
  ];
}
