{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kate
    playerctl
    obsidian
    neofetch
    pear-desktop
    easyeffects
    qpwgraph
  ];
}
