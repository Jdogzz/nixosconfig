{ pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "flakeuser";
  home.homeDirectory = "/home/flakeuser";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "org.kde.okular.desktop" ];
      "image/vnd.djvu" = [ "org.kde.okular.desktop" ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "impress.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/ftp" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
    };
  };

  home.packages = with pkgs; [

    #Browsers
    ungoogled-chromium

    #Development
    devenv
    direnv

    #Documents
    libreoffice
    mupdf
    okular
    pandoc
    pdfarranger
    poppler_utils
    texlive.combined.scheme-full
    xournalpp

    #Emacs
    #(emacs.override { withPgtk = true; })
    fd # Required for doom emacs
    fzf # Required for doom emacs
    ripgrep
    ripgrep-all

    #Emacs grammar check
    languagetool

    #Emacs programming
    black
    html-tidy
    nil
    nixfmt-rfc-style
    shellcheck
    shfmt

    #Emacs spelling check
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
        es
      ]
    ))

    #Email
    emacs.pkgs.mu4e

    #File management
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    rclone

    #Fonts
    corefonts # Cautiously reenabling, the download for this is brittle
    eb-garamond
    font-awesome
    garamond-libre
    liberation_ttf
    libre-caslon
    lmodern
    nerdfonts
    source-code-pro
    vistafonts

    #Hyprland add ons
    grimblast # Screenshot utility
    libnotify # Depedency of dunst
    slurp # Select utility
    wl-clipboard # xclip Alternative

    #Media
    jellyfin-media-player
    (kodi.passthru.withPackages (kodiPkgs: with kodiPkgs; [ jellyfin ]))
    mpv

    #Audio
    k3b
    picard

    #Books
    calibre

    #Images
    (imagemagick.override { libwebpSupport = true; })

    #Video
    ffmpeg
    makemkv
    mkvtoolnix
    yt-dlp

    #Password/secret management
    gcr # Apparently needed for gnome keyring to work.
    gnome.seahorse
    keepassxc

    #Reference management
    zotero

    #System monitoring
    htop
    iotop-c
    nvtopPackages.nvidia

    #Terminal software
    dotacat
    figlet
    grc

    #Video conference
    zoom-us

    #Virtual machines
    #These two packages were used to convert an img to a qcow2 file with sparsification. They are currently not needed.
    #guestfs-tools
    #libguestfs-with-appliance
    qemu_full
    (quickemu.override { qemu = qemu_full; })

    #VNC
    tigervnc

    #Windows compatibility
    bottles
    wine
    winetricks
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      figlet -f cosmic GTD | dotacat
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];
  };

  programs.starship = {
    enable = true;
  };

  #Set all things to dark mode
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  qt.enable = true;
  qt.style.name = "adwaita-dark";
  gtk.enable = true;
  gtk.theme.name = "Adwaita-dark";

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
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
          #Replacing the hotkey with Kodi for now while experiencing Nvidia driver crashes.
          #"$mod, J, exec, jellyfinmediaplayer --platform xcb"
          "$mod, K, exec, kodi"
          ", Print, exec, grimblast copy area"
          "$mod, R, exec, rofi -show drun -show-icons"
          "$mod, Q, exec, foot fish"
          "$mod, C, killactive"
          "$mod, E, exec, emacs"
          "$mod, V, togglefloating,"
          "$mod, L, exec, swaylock -i ~/gitrepos/nixosconfig/wallpaper.jpg"
          "$mod, S, exec, swaylock -i ~/gitrepos/nixosconfig/wallpaper.jpg & sleep 0.5 && systemctl suspend" # The 5 second delay is to try and avoid conflict between swaylock and suspending.
          "$mod, P, pseudo"
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
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "battery"
        ];
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
      };
    };
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

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "dmenu";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
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

  #On my list to get firefox profiles declaratively set
  programs.firefox = {
    enable = true;
    # profiles.flakeuser = {
    #   bookmarks = { };
    #   settings = {
    #     "browser.disableResetPrompt" = true;
    #     "browser.download.panel.shown" = true;
    #     "browser.download.useDownloadDir" = false;
    #     "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    #     "browser.shell.checkDefaultBrowser" = false;
    #     "browser.shell.defaultBrowserCheckCount" = 1;
    #     "browser.startup.page" = 3;
    #     "browser.tabs.firefox-view" = false;
    #     "dom.security.https_only_mode" = true;
    #     "extensions.pocket.enabled" = false;
    #     "identity.fxaccounts.enabled" = false;
    #     "privacy.trackingprotection.enabled" = true;
    #     "signon.rememberSignons" = false;
    #   };
    #   userChrome = ''
    #     /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_tabs_toolbar.css made available under Mozilla Public License v. 2.0
    #     See the above repository for updates as well as full license text. */

    #     /* Hides tabs toolbar */
    #     /* For OSX use hide_tabs_toolbar_osx.css instead */

    #     /* Note, if you have either native titlebar or menubar enabled, then you don't really need this style.
    #      * In those cases you can just use: #TabsToolbar{ visibility: collapse !important }
    #      */

    #     /* IMPORTANT */
    #     /*
    #     Get window_control_placeholder_support.css
    #     Window controls will be all wrong without it
    #     */

    #     :root[tabsintitlebar]{ --uc-toolbar-height: 40px; }
    #     :root[tabsintitlebar][uidensity="compact"]{ --uc-toolbar-height: 32px }
    #     #titlebar{
    #       will-change: unset !important;
    #       transition: none !important;
    #       opacity: 1 !important;
    #     }
    #     #TabsToolbar{ visibility: collapse !important }

    #     :root[sizemode="fullscreen"] #TabsToolbar > :is(#window-controls,.titlebar-buttonbox-container){
    #       visibility: visible !important;
    #       z-index: 2;
    #     }

    #     :root:not([inFullscreen]) #nav-bar{
    #       margin-top: calc(0px - var(--uc-toolbar-height,0px));
    #     }

    #     :root[tabsintitlebar] #toolbar-menubar[autohide="true"]{
    #       min-height: unset !important;
    #       height: var(--uc-toolbar-height,0px) !important;
    #       position: relative;
    #     }

    #     #toolbar-menubar[autohide="false"]{
    #       margin-bottom: var(--uc-toolbar-height,0px)
    #     }

    #     :root[tabsintitlebar] #toolbar-menubar[autohide="true"] #main-menubar{
    #       flex-grow: 1;
    #       align-items: stretch;
    #       background-attachment: scroll, fixed, fixed;
    #       background-position: 0 0, var(--lwt-background-alignment), right top;
    #       background-repeat: repeat-x, var(--lwt-background-tiling), no-repeat;
    #       background-size: auto 100%, var(--lwt-background-size, auto auto), auto auto;
    #       padding-right: 20px;
    #     }
    #     :root[tabsintitlebar] #toolbar-menubar[autohide="true"]:not([inactive]) #main-menubar{
    #       background-color: var(--lwt-accent-color);
    #       background-image: linear-gradient(var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor),var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor)), var(--lwt-additional-images,none), var(--lwt-header-image, none);
    #       mask-image: linear-gradient(to left, transparent, black 20px);
    #     }

    #     #toolbar-menubar:not([inactive]){ z-index: 2 }
    #     #toolbar-menubar[autohide="true"][inactive] > #menubar-items {
    #       opacity: 0;
    #       pointer-events: none;
    #       margin-left: var(--uc-window-drag-space-pre,0px)
    #     }
    #   '';
    # };
  };

  programs.foot = {
    enable = true;
    settings = {
      colors = {
        alpha = 0.8;
      };
    };
  };

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

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userEmail = "jerzor@pacbell.net";
    userName = "flakeuser";
  };

  #Tray disabled for now and I'll just use the browser interface
  #See https://github.com/nix-community/home-manager/issues/3416
  services.syncthing = {
    enable = true;
    # tray = {
    #   enable = true;
    # };
  };

  accounts.email = {
    accounts = {
      pacbell = {
        address = "jerzor@pacbell.net";
        primary = true;
        userName = "jerzor@pacbell.net";
        realName = "jerzor@pacbell.net";
        imap = {
          host = "imap.mail.att.net";
          port = 993;
          tls.enable = true;
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
        msmtp.enable = true;
        mu.enable = true;
        smtp = {
          host = "smtp.mail.att.net";
          port = 465;
          tls = {
            enable = true;
          };
        };
        passwordCommand = "cat /run/agenix/secret3";
        maildir.path = "pacbell";
      };
      outlook = {
        address = "virtualprocessor@outlook.com";
        userName = "virtualprocessor@outlook.com";
        realName = "virtualprocessor@outlook.com";
        imap = {
          host = "outlook.office365.com";
          port = 993;
          tls.enable = true;
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
        msmtp.enable = true;
        mu.enable = true;
        smtp = {
          host = "smtp-mail.outlook.com";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };
        passwordCommand = "cat /run/agenix/secret1";
        maildir.path = "outlook";
      };
      comcast = {
        address = "jerzor@comcast.net";
        userName = "jerzor@comcast.net";
        realName = "jerzor@comcast.net";
        imap = {
          host = "imap.comcast.net";
          port = 993;
          tls = {
            enable = true;
          };
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
        msmtp.enable = true;
        mu.enable = true;
        smtp = {
          host = "smtp.comcast.net";
          port = 587;
          tls.enable = true;
        };
        passwordCommand = "cat /run/agenix/secret2";
        maildir.path = "comcast";
      };
    };
    maildirBasePath = "generalsync/general-reference/emails";
  };

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;

  #Disabling this since I may have more than one computer active
  #I'll manually pull down mail when I need it
  # services.mbsync = {
  #   enable = true;
  #   postExec = "${pkgs.mu}/bin/mu index";
  # };

  services.lorri.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
