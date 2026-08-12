{ ... }: {

  imports = [
    ./hardware-configuration.nix

    # Системное ядро и загрузка
    ./modules/core/boot.nix
    ./modules/core/nix-settings.nix

    # Сеть, пользователи и локализация
    ./modules/network/default.nix
    ./modules/system/locale.nix
    ./modules/system/users.nix
    ./modules/system/sound.nix
    ./modules/system/bluetooth.nix
    ./modules/system/fonts.nix
    ./modules/system/hardware-tecno.nix

    # Графическое окружение
    ./modules/desktop/kde.nix
  ];

  system.stateVersion = "26.05";
}

