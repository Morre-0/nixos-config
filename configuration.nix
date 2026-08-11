{ pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    # ПОДКЛЮЧАЕМ НАШ НОВЫЙ МОДУЛЬ РАБОЧЕГО СТОЛА
    ./modules/desktop.nix
  ];

  # Загрузчик systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.initrd.luks.devices."crypted".preLVM = true;

  # Сеть и локализация
  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  # Пользователь системы
  users.users.slfhrmfn = {
    isNormalUser = true;
    description = "slfhrmfn";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Системные правила для Git
  programs.git = {
    enable = true;
    config.safe.directory = "/etc/nixos";
  };

  # Базовый софт для терминала
  environment.systemPackages = with pkgs; [
    nvim
    git
    curl
    wget
  ];

  # Алиасы команд
  environment.shellAliases = {
    nix-clean = "nix-env --delete-generations old && sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && sudo nix-collect-garbage -d && sudo nix-store --optimize && sudo nixos-rebuild boot --flake /etc/nixos/#nix-btw";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}

