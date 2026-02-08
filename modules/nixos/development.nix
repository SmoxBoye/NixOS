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
    ];
  };

  # nixpkgs.config.cudaSupport = true;
}
