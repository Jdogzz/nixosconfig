{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./networkmanagerapplet.nix
    ./stylix
  ];

  home.packages = with pkgs; [
    #Clipboard
    cliphist
    python312Packages.pyclip
    python312Packages.pyperclip
    wl-clipboard # xclip Alternative
    wl-clip-persist

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
      exec-once = [
        "hyprlock" # Sets up initial log in screen after boot
        "wl-paste --watch cliphist store" # Stores only text data
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox"
          "$mod, J, exec, jellyfinmediaplayer"
          "$mod, K, exec, kodi"
          ", Print, exec, grimblast copy area"
          "$mod, R, exec, fish -c 'fuzzel'"
          "$mod, Q, exec, foot fish"
          "$mod, C, killactive"
          "$mod, E, exec, emacs"
          "$mod, T, togglefloating,"
          "$mod, L, exec, hyprlock"
          "$mod, S, exec, hyprlock & sleep 0.2 && systemctl suspend"
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
      workspace = [
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
      windowrulev2 = [
        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.hyprland ];
    config.hyprland = {
      "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
      };
    };
  };

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

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        #icon-theme = "Papirus-Dark";
        width = 25;
        line-height = 20;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "${pkgs.foot}/bin/foot";
        prompt = "❯   ";
        layer = "overlay";
      };
      border.radius = 20;
      dmenu.exit-immediately-if-empty = "yes";
    };
  };

  xsession.preferStatusNotifierItems = true;

  programs.wlogout.enable = true;
}
