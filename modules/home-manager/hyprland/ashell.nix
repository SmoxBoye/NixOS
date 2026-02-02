{ config, pkgs, ... }:
{
  programs.ashell = {
    enable = true;
    settings = {
      workspaces = {
        visibility_mode = "MonitorSpecific";
      };
      position = "Bottom";
      modules = {
        left = [
          "Workspaces"
        ];
        center = [
          "WindowTitle"
          "Tray"
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
