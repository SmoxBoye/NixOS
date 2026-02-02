{ config, pkgs, ... }:
{
  programs.ashell = {
    enable = true;
    settings = {
      workspaces = {
        visibilityMode = "MonitorSpecific";
      };
      modules = {
        left = [
          "Workspaces"
        ];
        center = [
          "Window Title"
        ];
        right = [
          "System Info"
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
