{ config, pkgs, hostname, username, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall = {
        enable = true;
        allowedTCPPorts = [80 443 2222];
    };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  security.sudo.enable = true;

  # Enable the Budgie Desktop environment.
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
  };
  # services.displayManager.defaultSession = "none+bspwm";
  services.displayManager.sddm.extraPackages = with pkgs; [
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtdeclarative
    kdePackages.qt5compat
  ];
  services.xserver.desktopManager.budgie.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
    services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.udisks2.enable = true;

  programs.fish.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "nothing to see here";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
        tree
    ];
  };
  users.defaultUserShell = pkgs.fish;

  # Install firefox.
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    stow
    sddm-astronaut
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtdeclarative
    kdePackages.qt5compat
    bibata-cursors
    powerline-fonts
    nitch
    blueman
    bluez
    brightnessctl
    pavucontrol
    acl
    alsa-utils
    alsa-plugins
    alsa-lib
    pipewire
    jamesdsp
    imagemagick
    ffmpeg
    vlc
    mpv
    btop
    htop
    powertop
    curl
    bc
    killall
    usbutils
    pciutils
    unzip
    zip
    ripgrep
    bat
    tree
    which
    eza
    zoxide
    starship
    qbittorrent
    libreoffice-fresh
    brave
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;

  system.stateVersion = "25.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
