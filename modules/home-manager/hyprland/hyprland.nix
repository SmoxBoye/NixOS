{
  config,
  pkgs,
  inputs,
  ...
}:

let
  hyprnix = inputs.hyprnix.packages.${pkgs.stdenv.hostPlatform.system};

in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # Set flake package
    package = hyprnix.hyprland;
    portalPackage = hyprnix.xdg-desktop-portal-hyprland;
    xwayland.enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    settings = {
      "$mod" = "SUPER";
      env = [
        "HYPRCURSOR_SIZE,32"
      ];
      # cursor = {
      #   no_hardware_cursors = true;
      # };
      xwayland = {
        force_zero_scaling = true;
      };
      # Monitor configuration
      monitor = [
        # Dell S2417DG (left screen) - 2560x1440@120Hz with VRR 1.25 scaling before
        "DP-3, 2560x1440@120, auto-left, 1.0, vrr, 0"
        # CMT GP27-FUS (middle main screen) - 4K@120Hz with VRR
        "HDMI-A-1 ,3840x2160@120, 0x0, 1.0, vrr, 0"
        # "HDMI-A-1 ,3840x2160@120, 0x0, 1.5, vrr, 0"
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
        # "$mod, T, exec, yazi"
        "$mod, F, fullscreen"
        "$mod, W, togglefloating"
        "$mod, B, exec, firefox"

        "$mod, G, exec, myna"
        "$mod, P, exec, hyprctl dispatch dpms off && sleep 2 && hyprctl dispatch dpms on" # Fix my glitchy ass main screen when it flips out

        ", Print, exec, grimblast copy area"
        "Shift_L&$mod, S, exec, grimblast copy area" # Windows muscle memory has cursed me lmao

        # Focus movement
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Switch workspace with mouse
        "$mod, mouse:275, workspace, r-1"
        "$mod, mouse:276, workspace, r+1"

        # Lock
        "$mod, L, exec, hyprlock"

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

      bindn = [
        # Shell workspace preview
        "$mod, SUPER_L, global, quickshell:toggle-doors"

      ];

      # Startup applications
      exec-once = [
        # "hyprlock"
        "ashell"
        "swaync"
        "hyprpolkitagent" # Start polkit agent
        "[workspace 1 silent] kitty"
        "deltatune"
        "xrandr --output HDMI-A-1 --primary"
        "hyprpaper"
        "hyprsunset"
        "udiskie"
      ];

      # Visual settings
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgba(294559cc) rgba(295935cc) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "snappy, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 1, snappy, popin"
          "workspaces, 1, 2, snappy, slidefade"
        ];
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

  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
      allow_token_by_default = true
    }
  '';

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        # lock_cmd = "pidof hyprlock || hyprlock";
        lock_cmd = "loginctl kill-user $(whoami)";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150; # 2.5 min
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # {
        #   timeout = 150; # 2.5 min
        #   on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # Turn off keyboard backlight
        #   on-resume = "brightnessctl -rd rgb:kbd_backlight"; # Turn on keyboard backlight
        # }
        # {
        #   timeout = 300; # 5 min
        #   on-timeout = "loginctl lock-session";
        # }
        {
          timeout = 330; # 5.5 min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
        }
        # {
        #   timeout = 1800; # 30 min
        #   on-timeout = "systemctl suspend";
        # }
      ];
    };
  };

  services.hyprsunset = {
    enable = true;
    settings = {
      profile = [
        {
          time = "6:00";
          identity = true;
        }
        {
          time = "20:00";
          temperature = 5500;
        }
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "DP-3";
          path = "~/Pictures/Wallpapers/1a8xse74olce1.png";
          fit_mode = "cover";
        }
        {
          monitor = "DP-2";
          path = "~/Pictures/Wallpapers/2lf9aqtcdice1.png";
          fit_mode = "cover";
        }
        {
          monitor = "HDMI-A-1";
          path = "~/Pictures/Wallpapers/1a8xse74olce1.png";
          fit_mode = "cover";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "'<span foreground=\"\#\#cad3f5\">Password...</span>'";
          shadow_passes = 2;
        }
      ];
    };
  };
}
