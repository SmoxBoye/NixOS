{ config, pkgs, ... }:

{
  # home.packages = with pkgs; [
  # ];

  programs.yazi.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = "16";
    };
    themeFile = "Catppuccin-Mocha";
  };
}
