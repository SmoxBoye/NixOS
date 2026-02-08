{ config, pkgs, ... }:

{
  # home.packages = with pkgs; [
  # ];

  programs.yazi.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
    };
    themeFile = "Catppuccin-Mocha";
  };
}
