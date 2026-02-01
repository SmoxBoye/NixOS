{ config, pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Qt
      qt6.qtbase
      qt6.qtwayland
    ];
  };

  nixpkgs.config.cudaSupport = true;
}
