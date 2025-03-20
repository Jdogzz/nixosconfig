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
    #cups-pdf-to-pdf #2025-03-18 Removing as no longer needed.
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

    #Search
    ripgrep-all

    #System monitoring
    htop
    iotop-c

    #Terminal colorization
    dotacat
    grc

    #Terminal formatting
    figlet

    #2025-03-18 Removing since probably taken care of by stylix.
    #Theming
    # adwaita-icon-theme
    # papirus-icon-theme

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

  programs.starship = {
    enable = true;
  };

  programs.foot = {
    enable = true;
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

  #2025-03-20 Seems to no longer be necessary
  #Required for doom emacs
  # programs.fzf = {
  #   enable = true;
  # };

  programs.dircolors = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.mpv.enable = true;

  imports = [
    #inputs.hyprland.homeManagerModules.default
    ./modules/emacs
    ./modules/firefox
    ./modules/fish.nix
    ./modules/hyprland.nix
  ];
}
