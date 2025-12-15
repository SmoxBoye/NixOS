{ config, pkgs, ... }:

{
  # User packages
  home.packages = with pkgs; [
    kdePackages.kate
    vesktop
    git
    helix
    playerctl
    ghostty
    lazygit
  ];

  # Enable programs
  programs.yazi.enable = true;
  programs.home-manager.enable = true;

  # Import Home Manager modules
  imports = [
    ../../modules/home/browser.nix
    ../../modules/home/videogames.nix
  ];
}