{ pkgs, ... }: {
  # Включаем базовые графические службы Xserver
  services.xserver.enable = true;

  # Включаем современный дисплейный менеджер SDDM (Экран входа)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Запускаем сам SDDM на Wayland для плавности
  };

  # Настраиваем автоматический вход без пароля прямо в сессию KDE Plasma
  services.displayManager.autoLogin = {
    enable = true;
    user = "slfhrmfn";
  };

  # Включаем графическое окружение KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Добавляем полезный софт для кастомизации и нативный терминал
  environment.systemPackages = with pkgs; [
    kdePackages.konsole       # Родной, мощный терминал KDE
    kdePackages.kate          # Отличный текстовый редактор
    kdePackages.ark           # Архиватор
  ];
}

