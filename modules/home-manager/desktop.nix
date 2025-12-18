{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kate
    playerctl
    obsidian
  ];
}
