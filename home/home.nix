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

    #Calculation
    units

    #Development
    devenv

    #Documents
    libreoffice
    okular
    pandoc
    pdfarranger
    texlive.combined.scheme-full
    xournalpp

    #Emacs
    fd # Required for doom emacs
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

    #File management
    kdePackages.dolphin-plugins
    rclone

    #Fonts
    corefonts # Cautiously reenabling, the download for this is brittle
    eb-garamond
    font-awesome
    garamond-libre
    iosevka
    liberation_ttf
    libre-caslon
    lmodern
    material-design-icons
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    powerline-fonts
    source-code-pro
    vistafonts

    #Media
    jellyfin-media-player
    (kodi-wayland.passthru.withPackages (kodiPkgs: with kodiPkgs; [ jellyfin ]))

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
    keepassxc

    #Reference management
    zotero

    #System monitoring
    htop
    iotop-c

    #Terminal colorization
    dotacat
    grc

    #Terminal formatting
    figlet

    #Theming
    adwaita-icon-theme
    papirus-icon-theme

    #Video conference
    zoom-us

    #Virtual machines
    #These two packages were used to convert an img to a qcow2 file with sparsification. They are currently not needed.
    #guestfs-tools
    #libguestfs-with-appliance
    quickemu

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
      figlet Time to | dotacat
      figlet GTD | dotacat
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
    functions = {
      vterm_printf = {
        body = ''
          if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
              # tell tmux to pass the escape sequences through
              printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
          else if string match -q -- "screen*" "$TERM"
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$argv"
          else
              printf "\e]%s\e\\" "$argv"
          end
        '';
      };
    };
    shellAbbrs = {
      qrs = "rsync -achvP --mkpath ";
    };
    shellAliases = {
      vmlaunch = "quickemu --vm windows-11.conf --display spice --public-dir ~/Public/";
      zmzm = "QT_SCALE_FACTOR=0.5 zoom";
    };
    shellInit = ''
      set fish_greeting
    '';
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

  #Automatically synchronize with all mail servers and index it
  #Disabling this since I may have more than one computer active
  #I'll manually pull down mail when I need it
  # services.mbsync = {
  #   enable = true;
  #   postExec = "${pkgs.mu}/bin/mu index";
  # };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.mu4e
    ];
  };

  #Required for doom emacs
  programs.fzf = {
    enable = true;
  };

  programs.dircolors = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  #Added to speed up direnv usage with nix
  services.lorri.enable = true;

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        icon-theme = "Papirus-Dark";
        width = 25;
        font = "Hack:weight=bold:size=20";
        line-height = 20;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "${pkgs.foot}/bin/foot";
        prompt = "❯   ";
        layer = "overlay";
      };
      colors = {
        background = "282a36fa";
        selection = "3d4474fa";
        border = "fffffffa";
      };
      border.radius = 20;
      dmenu.exit-immediately-if-empty = "yes";
    };
  };

  programs.mpv.enable = true;

  imports = [ ./hyprland.nix ];
}
