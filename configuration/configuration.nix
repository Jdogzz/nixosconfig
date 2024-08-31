# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    hardware.pulseaudio.enable = false;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.flakeuser = {
    isNormalUser = true;
    description = "flakeuser";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
    #WLR_NO_HARDWARE_CURSORS = "1"; # Fixes invisible cursor in hyprland
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # LIBVA_DRIVER_NAME = "nvidia";
    # XDG_SESSION_TYPE = "wayland";
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_DRM_DEVICES = "/dev/dri/card1";
    # WLR_RENDER_DRM_DEVICE = "/dev/dri/card1";
  };

  #This overlay is needed because of the extra compile options for blurays. See https://github.com/NixOS/nixpkgs/issues/63641
  nixpkgs.overlays = [
    (self: super: {
      vlc = super.vlc.override {
        libbluray = super.libbluray.override {
          withAACS = true;
          withBDplus = true;
          withJava = true;
        };
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    #Archive management
    atool
    (p7zip.override { enableUnfree = true; })
    unrar
    unzip
    zip

    #Gaming
    gamemode
    gamescope
    lutris
    mangohud
    protonup-qt

    #Media
    vlc

    #Nix package management
    nix-tree # Can be used to resolve unusual package problems

    #Programming
    gcc
    git
    gnumake
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # Syncthing
  # 22000 TCP and/or UDP
  # 21027 for UDP discovery
  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.kernelModules = [ "sg" ];

  #Config for virtualization. Seems to be needed even just using quickemu.
  virtualisation = {
    libvirtd = {
      enable = true;
      # qemu = {
      #   package = pkgs.qemu_full;
      #   runAsRoot = true;
      #   swtpm.enable = true;
      #   ovmf = {
      #     enable = true;
      #     packages = [
      #       #(pkgs.OVMF.override {
      #       #  secureBoot = true;
      #       #  tpmSupport = true;
      #       #}).fd
      #       pkgs.OVMFFull.fd
      #     ];
      #   };
      # };
    };
    spiceUSBRedirection.enable = true;
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    # extraConfig = ''
    #   workgroup = WORKGROUP
    #   server string = smbnix
    #   netbios name = smbnix
    #   security = user
    #   #use sendfile = yes
    #   #max protocol = smb2
    #   # note: localhost is the ipv6 localhost ::1
    #   hosts allow = 192.168.0. 127.0.0.1 localhost
    #   hosts deny = 0.0.0.0/0
    #   guest account = nobody
    #   map to guest = bad user
    # '';
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  #Link portal definitions and DE provided configurations
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  programs.dconf.enable = true;

  services.btrfs.autoScrub.enable = true;

  services.fwupd.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  #imports = [ ./configuration-hyprland.nix ];
  imports = [ ./configuration-gnome.nix ];
}
