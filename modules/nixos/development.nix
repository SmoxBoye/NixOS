{ config, pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Qt
      qt6.qtbase
      qt6.qtwayland
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
      cudaPackages.libcublas
      cudaPackages.libcurand
      cudaPackages.libcufft
      cudaPackages.libnpp
      cudaPackages.cuda_cudart
      ffmpeg-full
      stdenv.cc.cc
    ];
  };

  nixpkgs.config.cudaSupport = true;
}
