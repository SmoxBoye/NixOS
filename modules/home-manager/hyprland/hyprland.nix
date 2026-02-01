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

      # Window management keybinds
      bind = [
        "$mod, Q, killactive"
        "$mod, Return, exec, kitty"
        "$mod, D, exec, rofi -show drun"
        "$mod, E, exec, dolphin"
        "$mod, T, exec, yazi"
        "$mod, F, fullscreen"
        "$mod, Space, togglefloating"
        "$mod, L, exec, swaync-client -t"
        "$mod, B, exec, firefox"
        ", Print, exec, grimblast copy area"

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

      # Startup applications
      exec-once = [
        "waybar"
        "swaync"
        "hyprpolkitagent" # Start polkit agent
        "[workspace 1 silent] kitty"
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
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };

      # Window rules
      windowrulev2 = [
        "float, class:^(rofi)$"
        "float, class:^(yazi)$"
        "float, class:^(swaync)$"
      ];
    };
  };
}
