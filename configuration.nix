# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.plymouth.enable = true;

  networking.hostName = "neonlights"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Luanda";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver = {
    desktopManager = {
      gnome.enable = true;
      	xterm.enable = false;
      };

      windowManager.i3 = {
	enable = true;
	extraPackages = with pkgs; [
	  dmenu
	  i3status
	  i3lock
	  i3blocks
	];
      };
  };

  # Necessary to allow GNOME theming with home-manager.
  programs.dconf.enable = true;

  # Enable Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Enable Waybar. Tray only works if enabled here.
  # programs.waybar.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.samuka = {
    isNormalUser = true;
    description = "Samuel";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "wwwrun" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix experimental features (including flakes)
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixFlakes;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim neovim
    zathura bottles
    vlc vscode gnumake unzip unrar p7zip
    transmission-gtk libreoffice 
    racket mitscheme
    wget gh
    firefox google-chrome discord
    winePackages.stableFull lutris vulkan-loader
    ntfs3g exfat unzip unrar p7zip gparted
    busybox
    pcmanfm jmtpfs # mount android devices

    gcc gdb ccls
    rustc rustfmt cargo rust-analyzer
    nodejs php
    ruby_3_1 rubyPackages_3_1.solargraph
    ocaml opam dune_3 ocamlPackages.utop ocamlPackages.odoc ocamlPackages.ounit2
    ocamlPackages.qcheck ocamlPackages.bisect_ppx ocamlPackages.menhir ocamlPackages.lsp
    ocamlformat ocamlPackages.ocamlformat-rpc-lib
    elixir elixir_ls erlang erlang-ls
    jdk clojure clojure-lsp boot
    ghc haskell-language-server cabal-install
  ];

  services.gvfs.enable = true;

  services.flatpak.enable = true;

  hardware.opengl.driSupport32Bit = true;

  services.httpd = {
    enable = true;
    enablePHP = true;
    adminAddr = "localhost";

    virtualHosts."localhost" = {
      documentRoot = "/var/www";
      enableSSL = false;
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    roboto
    font-awesome
    corefonts # Papa Gates fonts
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    inter
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
