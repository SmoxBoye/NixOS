{ config, pkgs, ... }:
{
  programs.ashell = {
    enable = true;
    settings = {
      workspaces = {
        visibility_mode = "MonitorSpecific";
      };
      modules = {
        left = [
          "Workspaces"
        ];
        center = [
          "WindowTitle"
        ];
        right = [
          "SystemInfo"
          [
            "Clock"
            "Privacy"
            "Settings"
          ]
        ];
      };
    };
  };
}
