{ config, pkgs }:
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
  ];

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
