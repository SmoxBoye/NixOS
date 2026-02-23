{ pkgs, ... }:
# let
#   patchedBwrap = pkgs.bubblewrap.overrideAttrs (o: {
#     patches = (o.patches or [ ]) ++ [
#       ./bwrap.patch
#     ];
#   });
# in
{
  #   programs.steam = {
  #     enable = true;
  #     package = pkgs.steam.override {
  #       buildFHSEnv = (
  #         args:
  #         (
  #           (pkgs.buildFHSEnv.override {
  #             bubblewrap = patchedBwrap;
  #           })
  #           (
  #             args
  #             // {
  #               extraBwrapArgs = (args.extraBwrapArgs or [ ]) ++ [ "--cap-add ALL" ];
  #             }
  #           )
  #         )
  #       );
  #       extraPkgs =
  #         pkgs: with pkgs; [
  #           xorg.libXcursor
  #           xorg.libXi
  #           xorg.libXinerama
  #           xorg.libXScrnSaver
  #           libpng
  #           libpulseaudio
  #           libvorbis
  #           stdenv.cc.cc.lib
  #           libkrb5
  #           keyutils
  #           wayland
  #           libxkbcommon
  #           vulkan-loader
  #           vulkan-validation-layers
  #           gamescope
  #         ];

  #     };
  #   };
}
