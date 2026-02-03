{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      "$mod" = "SUPER";

      cursor = {
        no_hardware_cursors = true;
      };

      # Monitor configuration
      monitor = [
        # Dell S2417DG (left screen) - 2560x1440@120Hz with VRR
        "DP-3, 2560x1440@120, auto-left, 1.25, vrr, 0"
        # CMT GP27-FUS (middle main screen) - 4K@120Hz with VRR
        "HDMI-A-1 ,3840x2160@120, 0x0, 1.5, vrr, 0"
        # Dell U2415 (right screen) - 1920x1200@60Hz, portrait (counterclockwise)
        "DP-2 ,1920x1200@60, auto-center-right, 1.0, transform, 1"
        # Misc monitor catchall https://wiki.hypr.land/Configuring/Monitors/
        ", preferred, auto, 1"
      ];

      # Enable VRR globally
      misc = {
        vrr = 1;
        middle_click_paste = false;
      };

      # Window management keybinds
      bind = [
        "$mod, Q, killactive"
        "$mod, Return, exec, kitty"
        "$mod, Space, exec, rofi -show drun"
        "$mod, E, exec, dolphin"
        "$mod, T, exec, yazi"
        "$mod, F, fullscreen"
        "$mod, W, togglefloating"
        "$mod, L, exec, swaync-client -t"
        "$mod, B, exec, firefox"
        ", Print, exec, grimblast copy area"
        "Shift_L&$mod, S, exec, grimblast copy area" # Windows muscle memory has cursed me lmao

        # Focus movement
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ]
      ++ (
        # Workspaces - binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Startup applications
      exec-once = [
        "ashell"
        "swaync"
        "hyprpolkitagent" # Start polkit agent
        "[workspace 1 silent] kitty"
        "deltatune"
      ];

      # Visual settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      # Input configuration
      input = {
        kb_layout = "se";
        follow_mouse = 1;
        sensitivity = 0;
      };

      # Window rules
      windowrule = [
        "match:class rofi, float on"
        "match:class swaync, float on"
        "match:class xdg-desktop-portal-gtk, float on"
        "match:class solaar, float on"
      ];
    };
  };
}
