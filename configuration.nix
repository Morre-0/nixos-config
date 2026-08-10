# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  environment.shellAliases = {
    nix-upgrade = "cd /etc/nixos && sudo nix flake update; sudo git add .; sudo git commit -m 'Update' || true; sudo nixos-rebuild switch --flake .#nix-btw";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    # Скачивать пакеты параллельно
    max-jobs = "auto";
    
    # Использовать все доступные ядра процессора для сборки
    cores = 0; 
    
    # Правильный адрес бинарного кэша
    substituters = [ "https://cache.nixos.org/" ];
    
    # Ключ проверки целостности кэша
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };

  # Bootloader.
  boot.loader.timeout = 5; # Меню будет отображаться 5 секунд
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fonts
  fonts.packages = with pkgs; [
    corefonts # Этот пакет содержит Comic Sans, Arial, Times New Roman и др.
    nerd-fonts.jetbrains-mono
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nix-btw"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru"; # Ваши раскладки
    options = "grp:caps_toggle"; # Переключение по Caps Lock
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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."slfhrmfn" = {
    isNormalUser = true;
    description = "slfhrmfn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      ghostty
      vlc
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    neovim
    fastfetch
    curl
    wget
    git
  ];

  system.stateVersion = "26.05";
}
