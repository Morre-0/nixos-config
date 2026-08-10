{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  environment.shellAliases = {
    nix-upgrade = "cd /etc/nixos && sudo nix flake update; sudo git add .; sudo git commit -m 'Update' || true; sudo nixos-rebuild switch --flake .#nix-btw";
    zapret-start = "cd /home/slfhrmfn/zapret-discord-youtube-linux && sudo ./service.sh run --config conf.env";
  };

  nix.settings = {
    max-jobs = "auto";
    cores = 0; 
    # ИСПРАВЛЕНО: Теперь здесь правильный бинарный кэш
    substituters = [ "https://nixos.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Служба автозапуска zapret
  systemd.services.zapret-auto = {
    description = "Zapret Bypass Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [ 
      nftables 
      iptables 
      gawk 
      curl 
      wget 
      coreutils 
      procps 
      bash 
    ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "/home/slfhrmfn/zapret-discord-youtube-linux/service.sh run --config /home/slfhrmfn/zapret-discord-youtube-linux/conf.env";
      Restart = "always";
      RestartSec = "5";
      WorkingDirectory = "/home/slfhrmfn/zapret-discord-youtube-linux";
      Environment = "PATH=/run/current-system/sw/bin";
    };
  };

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

  # User Account
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

