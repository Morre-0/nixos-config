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

    # Графическое окружение
    ./modules/desktop.nix
    
    # ИСПРАВЛЕНО: Явно подключаем созданный модуль софта Waybar
    ./modules/desktop/hyprland-apps.nix
  ];

  # Точка отсчёта обратной совместимости системы
  system.stateVersion = "26.05";
}

