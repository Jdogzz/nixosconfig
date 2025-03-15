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
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "calc.desktop" ];
      "application/vnd.oasis.opendocument.spreadsheet" = [ "calc.desktop" ];
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
      "application/epub+zip" = [ "calibre-ebook-viewer.desktop" ];
    };
  };

  nixpkgs.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [

    #Browsers
    ungoogled-chromium

    #Calculation
    units

    #Communication
    simplex-chat-desktop
    zoom-us

    #Development
    devenv

    #Documents
    cups-pdf-to-pdf
    #k2pdfopt #2025-01-31 Removing while build failure https://github.com/NixOS/nixpkgs/issues/376898
    libreoffice
    kdePackages.okular
    pandoc
    #paps #2025-01-03 Disabling due to build failure, not used often so may be okay to remove.
    pdfarranger
    texlive.combined.scheme-full
    xournalpp

    #Document languages: Needed to enable libreoffice spell check
    hunspellDicts.en_US
    hunspellDicts.es_MX

    #Emacs
    fd # Required for doom emacs
    ripgrep
    ripgrep-all

    #Emacs grammar check
    languagetool

    #Emacs programming
    black
    cmake
    html-tidy
    nil
    nixfmt-rfc-style
    nodePackages.prettier
    shellcheck
    shfmt

    #Emacs tools
    ghostscript # Adding for DocView previewing
    libtool # Adding for vterm compilation
    mupdf # Adding for DocView previewing
    unoconv # Adding for DocView Office document previewing

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
    #maildrop #2024-12-27 Build failures so commenting this out

    #File management
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
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    powerline-fonts
    source-code-pro
    vistafonts

    #Hardware information
    pciutils

    #Media
    jellyfin-media-player
    # (kdePackages.k3b.override # Removing transcode dependency while waiting for PR: https://github.com/NixOS/nixpkgs/pull/358364
    #   { transcode = null; }
    # )
    kdePackages.k3b
    (kodi-wayland.passthru.withPackages (kodiPkgs: with kodiPkgs; [ jellyfin ]))

    #Audio
    picard

    #Books
    (calibre.override {
      unrarSupport = true;
    })

    #Images
    darktable
    gimp-with-plugins
    (imagemagick.override { libwebpSupport = true; })

    #Video
    ffmpeg
    makemkv
    mkvtoolnix
    yt-dlp

    #Network monitoring
    traceroute

    #Password/secret management
    keepassxc

    #Reference management
    zotero

    #RSS downloader
    ua
    jq # Requirement for ua

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
      winvmlaunch = "quickemu --vm windows-11.conf --display spice --public-dir ~/Public/";
      browservmlaunch = "quickemu --vm ubuntu-24.10.conf --display spice --public-dir ~/Public/";
      zmzm = "QT_SCALE_FACTOR=0.5 zoom";
      ppngxlaunch = "systemctl start redis-paperless.service system-paperless.slice paperless-scheduler.service gotenberg.service tika.service";
      ppngxstop = "systemctl stop system-paperless.slice redis-paperless.service gotenberg.service tika.service";
    };
    shellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    # settings = {
    #   colors = {
    #     alpha = 0.8;
    #   };
    # };
  };

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userEmail = "jerzor@pacbell.net";
    userName = "flakeuser";
  };

  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
    };
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
      # outlook = {
      #   address = "virtualprocessor@outlook.com";
      #   userName = "virtualprocessor@outlook.com";
      #   realName = "virtualprocessor@outlook.com";
      #   imap = {
      #     host = "outlook.office365.com";
      #     port = 993;
      #     tls.enable = true;
      #   };
      #   mbsync = {
      #     enable = true;
      #     create = "maildir";
      #     expunge = "both";
      #   };
      #   msmtp.enable = true;
      #   mu.enable = true;
      #   smtp = {
      #     host = "smtp-mail.outlook.com";
      #     port = 587;
      #     tls = {
      #       enable = true;
      #       useStartTls = true;
      #     };
      #   };
      #   passwordCommand = "cat /run/agenix/secret1";
      #   maildir.path = "outlook";
      # };
      # comcast = {
      #   address = "jerzor@comcast.net";
      #   userName = "jerzor@comcast.net";
      #   realName = "jerzor@comcast.net";
      #   imap = {
      #     host = "imap.comcast.net";
      #     port = 993;
      #     tls = {
      #       enable = true;
      #     };
      #   };
      #   mbsync = {
      #     enable = true;
      #     create = "maildir";
      #     expunge = "both";
      #   };
      #   msmtp.enable = true;
      #   mu.enable = true;
      #   smtp = {
      #     host = "smtp.comcast.net";
      #     port = 587;
      #     tls.enable = true;
      #   };
      #   passwordCommand = "cat /run/agenix/secret2";
      #   maildir.path = "comcast";
      # };
    };
    maildirBasePath = "generalsync/reference/emails";
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
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: [
      #epkgs.vterm #2025-03-08 Disabling for broken build.
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

  programs.mpv.enable = true;

  imports = [
    #inputs.hyprland.homeManagerModules.default
    ./modules/hyprland.nix
    ./modules/firefox
  ];
}
