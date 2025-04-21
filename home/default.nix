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
    #Calculation
    units

    #Communication
    simplex-chat-desktop
    zoom-us

    #Documents
    #cups-pdf-to-pdf #2025-03-18 Removing as no longer needed.
    graphviz
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

    #File management
    rclone

    #Hardware information
    pciutils

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

  imports = [
    ./modules
  ];
}
