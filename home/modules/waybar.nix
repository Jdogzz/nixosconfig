{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        # output = [
        #   "DP-3"
        #   "eDP-1"
        # ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "tray"
          "wireplumber"
          "battery"
          "clock"
          "custom/power"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "on-click" = "activate";
        };
        "hyprland/window" = {
          "max-length" = 200;
          "separate-outputs" = true;
        };
        clock = {
          format = " {:%H:%M:%S %Z 󰸘 %y/%m/%d}";
          interval = 20;
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        battery = {
          interval = 60;
          states = {
            "warning" = 30;
            "critical" = 15;
          };
          format = "{capacity}% {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        wireplumber = {
          format = "{volume}% {icon}";
          "format-muted" = "";
          "on-click" = "pavucontrol";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "custom/power" = {
          "format" = "";
          "on-click" = "wlogout";
          "on-click-right" = "hyprlock";
          "tooltip-format" = "Left: Power menu\nRight: Lock screen";
        };
      };
    };
    # style = ''
    #         * {
    #           border: none;
    #           border-radius: 0;
    #           font-family: JetBrainsMono Nerd Font, sans-serif;
    #         }
    #         window#waybar {
    #           background: #16191C;
    #           color: #AAB2BF;
    #         }
    #   #workspaces button {
    #       padding: 0 5px;
    #       background: transparent;
    #       color: white;
    #       border-bottom: 3px solid transparent;
    #   }
    #   #workspaces button.active {
    #       background: #64727D;
    #       border-bottom: 3px solid white;
    #   }
    # '';
    systemd = {
      enable = true;
    };
  };
}
