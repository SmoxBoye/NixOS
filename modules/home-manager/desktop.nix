{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Existing desktop apps
    kdePackages.kate
    playerctl
    obsidian
    fastfetch
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
    awww
    wlogout

    # Essential Wayland utilities
    wl-clipboard
    networkmanagerapplet

    # System tray utilities
    power-profiles-daemon
    brightnessctl

    # Fonts
    noto-fonts
    corefonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    ipafont

    # Bruh
    usbutils
    tinyxxd
    hidrd
    jq

    protonplus

    zip
    unzip
    unrar
    bs-manager

    prismlauncher
    dconf
    # pureref

    qalculate-gtk

    btop

    smartmontools

    ardour
    cbonsai

    qgis

    ffmpeg-full
    ckan
    bc

    aria2

    wget

    taskwarrior3
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

  services.easyeffects = {
    enable = true;
    preset = "Discord";
  };

}
