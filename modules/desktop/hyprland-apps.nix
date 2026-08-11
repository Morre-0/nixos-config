{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Интерфейс
    alacritty
    waybar              # Твой статус-бар
    rofi        # Меню запуска приложений
    dunst               # Сервер уведомлений
    swww                # Менеджер обоев

    # Утилиты экрана и буфера
    grim                # Скриншоты
    slurp               # Выбор области для скриншота
    wl-clipboard        # Буфер обмена
    cliphist            # История буфера обмена

    # Системное
    xfce.thunar         # Файловый менеджер
    lxappearance        # Настройка GTK тем
  ];

  # Включаем важный портал для правильной работы скриншотов в Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}

