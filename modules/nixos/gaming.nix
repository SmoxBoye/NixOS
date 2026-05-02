{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
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
    capSysNice = false;
  };

  services.ratbagd.enable = true;
  hardware.logitech.wireless.enable = true;
  services.solaar.enable = true;
  environment.systemPackages = with pkgs; [
    mangohud
    gamemode
    # vintagestory
    space-cadet-pinball
    supertuxkart
    libratbag
    upower
    xrandr

    # Custom KSP Launcher
    (makeDesktopItem {
      name = "ksp";
      desktopName = "Kerbal Space Program";
      comment = "To the Mun!";
      exec = "${writeShellScript "launch-ksp" ''
        cd "/home/smoxboye/mnt/2tbnvme/Kerbal Space Program/KSP_linux"
        ./gcroots/ksp-link/bin/ksp-environment
      ''}";
      icon = "/home/smoxboye/mnt/2tbnvme/Kerbal Space Program/KSP_linux/KSP_Data/Resources/UnityPlayer.png";
      terminal = false;
      categories = [ "Game" ];
      keywords = [
        "kerbal"
        "space"
        "ksp"
      ];
    })
  ];
  # services.monado = {
  #   enable = true;
  #   defaultRuntime = true; # Register as default OpenXR runtime
  # };

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
    applications = {
      apps = [
        {
          name = "Slay the Spire 2";
          detached = "root -u smoxboye setsid steam steam://rungameid/2868840";
        }
        {
          name = "Steam Big Picture";
          image-path = "steam.png";
          detached = [ "${lib.getExe pkgs.steam} steam://open/bigpicture" ];
          auto-detach = "true";
          wait-all = "true";
          exit-timeout = "5";
        }
      ];
    };
  };

}
