{ config, pkgs, ... }:

{
  home.file.".config/ashell/solaar-check.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash

      trap "echo 'Terminating...'; exit 0" SIGTERM SIGINT

      while true; do
        PERCENT=$(solaar show "PRO X Wireless" | grep -i "Battery" | grep -oP '\d+%' | head -n1)
        if [ -n "$PERCENT" ]; then
          VALUE=''${PERCENT%\%}
            
            # Determine the 'alt' status
            if [ "$VALUE" -le 20 ]; then
                ALT="low"
            else
                ALT="notification"
            fi
            
            printf '{"text": "%s", "alt": "%s"}\n' "$PERCENT" "$ALT"
        else
            printf '{"text": "Offline", "alt": "disconnected"}\n' 
        fi
        sleep 300 & wait $!
      done 
    '';
  };

  programs.ashell = {
    enable = true;
    settings = {
      CustomModule = [
        {
          name = "SolaarBattery";
          icon = "󰍽"; # Or "󰍽" for a mouse icon
          command = "echo Starting";
          listen_cmd = "/home/smoxboye/.config/ashell/solaar-check.sh";
          # This maps the "alt" field from your JSON to specific icons
          icons = {
            "notification" = "󰍽"; # Icon when connected
            "disconnected" = "󰍾"; # Icon when offline
          };
          alert = ".*low";
        }
      ];

      appearance = {
        style = "Gradient";
      };
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
          "SolaarBattery"
          [
            "Clock"
            "Privacy"
            "Settings"
          ]
        ];
      };
      settings = {
        indicators = [
          "Audio"
          "Network"
        ];
        shutdown_command = "hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'";
        reboot_cmd = "hyprshutdown -t 'Restarting...' --post-cmd 'reboot'";
        remove_airplane_btn = true;
      };
    };
  };
}
