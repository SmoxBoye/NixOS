{ config, pkgs, inputs, ... }:

{
  # Home Manager settings
  home.username = "smoxboye";
  home.homeDirectory = "/home/smoxboye";
  home.stateVersion = "25.11";

  # Packages that were in users.users.smoxboye.packages
  home.packages = with pkgs; [
    kdePackages.kate
  ];

  # Packages that were in environment.systemPackages (user-specific)
  home.packages = with pkgs; [
    vesktop
    git
    helix
    playerctl
    ghostty
    lazygit
  ];

  # Enable programs that were system-wide
  programs.yazi.enable = true;

  # Home Manager specific configurations can go here
  programs.home-manager.enable = true;
}