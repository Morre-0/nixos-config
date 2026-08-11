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
    
    # ИСПРАВЛЕНО: Добавляем специализированные модули
    ./modules/system/sound.nix
    ./modules/system/bluetooth.nix

    # Графическое окружение (теперь только чистый Hyprland)
    ./modules/desktop.nix
  ];

  system.stateVersion = "26.05";
}

