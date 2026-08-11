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

    # Графическое окружение (ТОЛЬКО RIVER, БЕЗ СТАРОГО DESKTOP.NIX)
    ./modules/desktop/river.nix
    ./modules/desktop/hyprland-apps.nix
  ];

  # Точка отсчёта обратной совместимости системы
  system.stateVersion = "26.05";
}

