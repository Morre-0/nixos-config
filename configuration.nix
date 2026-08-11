{ ... }: {

  imports = [
    # Аппаратная часть
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

    # Графическое окружение (ИСПРАВЛЕНО: Чистый GNOME как в Fedora)
    ./modules/desktop/gnome.nix
  ];

  system.stateVersion = "26.05";
}

