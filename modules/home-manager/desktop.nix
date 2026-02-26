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
    signal-desktop

    # Essential applications referenced in keybinds
    kdePackages.dolphin

    # Hyprland ecosystem
    grimblast
    slurp
    swaynotificationcenter
    rofi
    swww
    wlogout

    # Essential Wayland utilities
    wl-clipboard
    networkmanagerapplet

    # System tray utilities
    power-profiles-daemon
    brightnessctl

    # Fonts
    noto-fonts

    # Bruh
    usbutils
    tinyxxd
    hidrd
    jq

    protonplus

    easyeffects
    unzip
    bs-manager
  ];

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

}
