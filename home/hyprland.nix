{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    #Clipboard
    cliphist
    wl-clipboard # xclip Alternative

    #File management
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kdegraphics-thumbnailers

    #Notifications
    libnotify # Dependency of dunst

    #Password/secret management
    gcr # Apparently needed for gnome keyring to work.
    seahorse

    #Screenshots
    grimblast # Screenshot utility

    #Wayland
    slurp # Select utility

  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    #package = inputs.hyprland.packages.x86_64-linux.hyprland;
    settings = {
      "exec-once" = "wl-paste --watch cliphist store"; # Stores only text data
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
        "col.active_border" = "rgb(78A8FF) rgb(7676FF) 45deg";
        "col.inactive_border" = "rgba(585272aa)";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        no_gaps_when_only = 1;
      };
      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox"
          "$mod, J, exec, jellyfinmediaplayer --platform xcb"
          #"$mod, K, exec, kodi"
          ", Print, exec, grimblast copy area"
          "$mod, R, exec, fish -c 'fuzzel'"
          "$mod, Q, exec, foot fish"
          "$mod, C, killactive"
          "$mod, E, exec, emacs"
          "$mod, T, togglefloating,"
          "$mod, L, exec, swaylock -i ~/gitrepos/nixosconfig/wallpaper.jpg"
          "$mod, S, exec, swaylock -i ~/gitrepos/nixosconfig/wallpaper.jpg & sleep 0.5 && systemctl suspend" # The 5 second delay is to try and avoid conflict between swaylock and suspending.
          "$mod, P, pseudo"
          "$mod, V, exec, cliphist list | fuzzel --dmenu --width=50 | cliphist decode | wl-copy"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod, Tab, cyclenext," # change focus to another window
          "$mod, Tab, bringactivetotop," # bring it to the top
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod,mouse_down,workspace,e-1"
          "$mod,mouse_up,workspace,e+1"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [ ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];
      bindm = [ "$mod, mouse:272, movewindow" ];
      monitor = [ "Unknown-1,disable" ]; # This kills the ghost monitor that the NVIDIA driver just made.
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "overshot,0.05,0.9,0.1,1.1"
          "overshot,0.13,0.99,0.29,1."
        ];
        animation = [
          "windows,1,7,overshot,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,7,overshot,slidevert"
        ];
      };
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-3"
          "eDP-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "tray"
          "wireplumber"
          "battery"
          "clock"
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
          "on-click" = "helvum";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
      };
    };
    style = ''
            * {
              border: none;
              border-radius: 0;
              font-family: JetBrainsMono Nerd Font, sans-serif;
            }
            window#waybar {
              background: #16191C;
              color: #AAB2BF;
            }
      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-bottom: 3px solid transparent;
      }
      #workspaces button.active {
          background: #64727D;
          border-bottom: 3px solid white;
      }
    '';
    systemd = {
      enable = true;
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/gitrepos/nixosconfig/wallpaper.jpg" ];
      wallpaper = [ ",~/gitrepos/nixosconfig/wallpaper.jpg" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    #configPackages = [ inputs.hyprland.packages.x86_64-linux.hyprland ];
    configPackages = [ pkgs.hyprland ];
  };

  #There are some serious issues using hyprlock with Nvidia, disabling this and using swaylock until things are fixed
  #See e.g. https://github.com/hyprwm/hyprlock/issues/128
  # programs.hyprlock = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       disable_loading_bar = true;
  #       grace = 300;
  #       hide_cursor = true;
  #       no_fade_in = false;
  #     };

  #     background = [
  #       {
  #         path = "~/gitrepos/nixosconfig/wallpaper.jpg"; # "screenshot";
  #         # blur_passes = 3;
  #         # blur_size = 8;
  #       }
  #     ];

  #     input-field = [
  #       {
  #         size = "200, 50";
  #         position = "0, -80";
  #         monitor = "";
  #         dots_center = true;
  #         fade_on_empty = false;
  #         font_color = "rgb(202, 211, 245)";
  #         inner_color = "rgb(91, 96, 120)";
  #         outer_color = "rgb(24, 25, 38)";
  #         outline_thickness = 5;
  #         placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
  #         shadow_passes = 2;
  #       }
  #     ];
  #   };
  # };

  #Support for notifications.
  services.dunst.enable = true;

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  services.network-manager-applet.enable = true;

  #Set all things to dark mode
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  qt.enable = true;
  qt.style.name = "adwaita-dark";
  gtk.enable = true;
  gtk.theme.name = "Adwaita-dark";

}
