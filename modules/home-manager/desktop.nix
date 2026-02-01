{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Existing desktop apps
    kdePackages.kate
    playerctl
    obsidian
    neofetch
    pear-desktop
    easyeffects
    qpwgraph
    blender
    obs-studio

    # Essential applications referenced in keybinds
    kdePackages.dolphin

    # Hyprland ecosystem
    grimblast
    slurp
    swaynotificationcenter
    rofi
    waybar
    yazi
    swww
    wlogout

    # Essential Wayland utilities
    wl-clipboard
    networkmanagerapplet

    # System tray utilities
    power-profiles-daemon
    brightnessctl
  ];
}
