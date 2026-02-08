{ config, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = false;
    flake = "/home/smoxboye/myflake";
  };
}
