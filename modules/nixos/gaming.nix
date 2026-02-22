{ config, pkgs, ... }:
{
  programs.steam =
    let
      patchedBwrap = pkgs.bubblewrap.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
          ./bwrap.patch
        ];
      });
    in
    {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];

      gamescopeSession.enable = true;

      package = pkgs.steam.override {
        buildFHSEnv = (
          args:
          (
            (pkgs.buildFHSEnv.override {
              bubblewrap = patchedBwrap;
            })
            (
              args
              // {
                extraBwrapArgs = (args.extraBwrapArgs or [ ]) ++ [ "--cap-add ALL" ];
              }
            )
          )
        );
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
    capSysNice = false;
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

}
