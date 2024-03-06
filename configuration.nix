# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, ... }:


{
###     
# BELOW IS REMOVED TO WORK WITH REMOTE FILE IN /etc/nixos/configuration.nix WHICH POINTS TO THIS FILE
 imports =
   [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
     ./packages.nix
     ./python-packages.nix
   ];
###   
# Trying flakes



 ## Adding VIA and QMK support to edit keyboard settings 

  hardware.keyboard.qmk.enable = true; 


  # udev rules to give R/W access keyboard (which came to /dev/hidraw2)
  services.udev.packages = with pkgs; [ via vial ];
  services.udev.extraRules = ''
  KERNEL=="hidraw2", MODE="0666"
   SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0042", MODE="0660", TAG+="uaccess"
  '';
  # Above USB udev rule is for yanns ultimaker original + 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; 

  networking.hostName = "nixos-desk"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  

  # Enable firewall and open ports for jellyfin

  networking.firewall = {
  enable = true;
  allowedUDPPorts = [ 53 80 88 500 3544 4500 1900 7359 6881 7881 8881 25565];
  allowedUDPPortRanges = [
     {from = 4000; to = 8000;} # þarf þetta fyrir minecraft
     {from = 19132; to = 19133;}
   ];

  allowedTCPPorts = [ 53 80 443 3074 4096 8096 8123 8920 25565];
  allowedTCPPortRanges =[
    {from = 20000; to = 60000;} # bætti við 20000 til 60000 tcp fyrir minecraft
  ];


  # Port 8123 (TCP) fyrir home assistant
# minecraft UDP 19132-19133 25565 + TCP 25565
# UDP 6881, 7881 and 8881 for ktorrent and bit torrents
# UDP 8096 fyrir jellyfin. 
# Ports 25565 UDP and TCP or others for client-to-client connection.  
# Port 88 (UDP)
# Port 3074 (UDP and TCP)
# Port 53 (UDP and TCP)
# Port 80 (TCP)
# Port 500 (UDP)
# Port 3544 (UDP)
# Port 4500 (UDP)

};
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings.LC_MEASUREMENT = "fr_CH.UTF-8";
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "plasmax11";
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "is";
    xkb.variant = "";
  };


  # add bluetooth

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  }; 
  # Configure console keymap
  console.keyMap = "is-latin1"; 

  # Enable CUPS to print documents.
  services.printing.enable = true;
  ###
  # Added avahi services for printers
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
  ###


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
  users.users.kodak = {
    isNormalUser = true;
    description = "kodak";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2skTJEMcfxQ0JX9W5Ex9oPLDE3oEMtyS8yuncDe2rK d@olafsson.ch"
    ]; # Þetta er samt bara til að fjartengjast tölvunni, og nota þennan lykil til þess. 
    packages = with pkgs; [
    ];
  };
  # set Zsh as default
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;
services.openssh = {
  enable = true;
  #  add more services.ssh settings here
  };

# home-manager.users.kodak = import ./home.nix;

### 
# Adding fonts 

fonts.packages = with pkgs; [
  fira-code
  fira-code-symbols
];


  # Allow unfree packag
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

#   environment.variables.EDITOR = "emacs"; 
# nixpkgs.overlays = [
#   (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
# ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
services.flatpak.enable = true;
# Automatic Garbage Collection
nix.gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
        };
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		 };

# Enable docker
virtualisation = {
  docker.enable = true;
  docker.liveRestore = false; # to fix 90s delay on "s6-svcan" on power-off or reboot
}; 

nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
