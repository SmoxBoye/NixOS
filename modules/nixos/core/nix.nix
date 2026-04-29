{ config, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = false;
    clean.extraArgs = "--keepsince 7d --keep 5 --optimise";
    flake = "/home/smoxboye/myflake";
  };
}
