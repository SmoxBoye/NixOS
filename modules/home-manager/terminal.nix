{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  programs.yazi.enable = true;
}
