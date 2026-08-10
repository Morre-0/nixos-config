{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  environment.shellAliases = {
    nix-upgrade = "cd /etc/nixos && sudo nix flake update; sudo git add .; sudo git commit -m 'Update' || true; sudo nixos-rebuild switch --flake .#nix-btw";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings = {
    max-jobs = "auto";
    cores = 0; 
    substituters = [ "https://nixos.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  };
#zapret
  # Включаем официальную службу zapret с вашей стратегией general_alt11.bat
  services.zapret = {
    enable = true;
    
    # Автоматически загружать параметры из репозитория
    params = [
      "--nfwqws-enable=yes"
      
      # Параметры стратегии general_alt11 (split по умолчанию)
      "--filter-tcp=80,443 --dpi-desync=split2"
      "--filter-udp=443,50000-65535 --dpi-desync=fake --dpi-desync-repeats=6"
    ];
  };
#moe1
# Включаем nftables, так как он обязателен для работы скрипта zapret
networking.nftables.enable = true;

  # Bootloader
  boot.loader.timeout = 5;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fonts
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.jetbrains-mono
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;

  # Locale & TimeZone
  time.timeZone = "Europe/Moscow";
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

  # Graphics & Desktop (GNOME)
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:caps_toggle";
  };

  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User Account (Чистый блок, без незакрытых скобок)
  users.users."slfhrmfn" = {
    isNormalUser = true;
    description = "slfhrmfn";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    neovim
    fastfetch
    curl
    wget
    git
  ];

  system.stateVersion = "26.05";
}

