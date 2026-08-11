{ ... }: {
  # Включаем X11/Wayland графический сервер Xserver
  services.xserver.enable = true;

  # Включаем дисплейный менеджер GDM (Экран входа)
  services.xserver.displayManager.gdm.enable = true;

  # Включаем само графическое окружение GNOME
  services.xserver.desktopManager.gnome.enable = true;
}

