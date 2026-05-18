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

    configType = "lua";

    settings = {
      # env = [
      #   "HYPRCURSOR_SIZE,32"
      # ];
      # xwayland = {
      #   force_zero_scaling = true;
      # };
      # monitor = [
      #   "DP-3, 2560x1440@120, auto-left, 1.0, vrr, 0"
      #   "HDMI-A-1 ,3840x2160@120, 0x0, 1.0, vrr, 0"
      #   "DP-2 ,1920x1200@60, auto-center-right, 1.0, transform, 1"
      #   ", preferred, auto, 1"
      # ];
    };

    extraConfig = ''
      require("smoxboye.init")
    '';
  };

  xdg.configFile = {
    "hypr/smoxboye/init.lua".source = ./lua/init.lua;
    "hypr/smoxboye/settings.lua".source = ./lua/settings.lua;
    "hypr/smoxboye/binds.lua".source = ./lua/binds.lua;
    "hypr/smoxboye/windowrules.lua".source = ./lua/windowrules.lua;
    "hypr/smoxboye/startup.lua".source = ./lua/startup.lua;
    "hypr/smoxboye/music.lua".source = ./lua/music.lua;
    "hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
      }
    '';
  };

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
