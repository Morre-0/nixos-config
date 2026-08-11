{ pkgs, ... }: {
  # Включаем базовые графические службы Xserver
  services.xserver.enable = true;

  # Включаем официальный дисплейный менеджер GDM (Экран входа)
  services.xserver.displayManager.gdm.enable = true;

  # Включаем полноценное графическое окружение GNOME
  services.xserver.desktopManager.gnome.enable = true;

  # Добавляем нативный терминал GNOME и утилиту настроек (как в Fedora)
  environment.systemPackages = with pkgs; [
    gnome-console      # Дефолтный современный терминал GNOME
    gnome-tweaks       # Дополнительные настройки тем и шрифтов
  ];

  # Гарантируем, что стандартные утилиты GNOME включены на полную мощность
  services.gnome.core-utilities.enable = true;
}

