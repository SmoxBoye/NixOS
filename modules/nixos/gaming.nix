{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          wayland
          libxkbcommon
          vulkan-loader
          vulkan-validation-layers
          gamescope
        ];
    };

    extraPackages = with pkgs; [ mangohud ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
    };
  };

  hardware.steam-hardware.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  services.ratbagd.enable = true;
  hardware.logitech.wireless.enable = true;
  services.solaar.enable = true;
  environment.systemPackages = with pkgs; [
    mangohud
    gamemode
    vintagestory
    space-cadet-pinball
    superTuxKart
    libratbag
    upower
    xorg.xrandr
  ];
  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
  };

}
