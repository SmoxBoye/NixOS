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
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/videogames.nix
  ];
}
