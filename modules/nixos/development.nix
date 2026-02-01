{ config, pkgs, ... }:
{
  programs.nix-ld.enable = true;
  nixpkgs.config.cudaSupport = true;
}
