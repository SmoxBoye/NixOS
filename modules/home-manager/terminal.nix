{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  programs.yazi.enable = true;
}