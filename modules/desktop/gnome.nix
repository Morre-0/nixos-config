{ pkgs, ... }: {
  # Включаем базовые графические службы
  services.xserver.enable = true;

  # Включаем дисплейный менеджер GDM (Wayland тут включен по умолчанию)
  services.xserver.displayManager.gdm.enable = true;

  # Включаем полноценное графическое окружение GNOME
  services.xserver.desktopManager.gnome.enable = true;

  # Добавляем нативный терминал GNOME и базовые утилиты
  environment.systemPackages = with pkgs; [
    gnome-console      # Современный дефолтный терминал GNOME
    gnome-tweaks       # Утилита для настройки тем и расширений
  ];

  # Гарантируем, что полные утилиты GNOME включены
  services.gnome.core-utilities.enable = true;
}

