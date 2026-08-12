{ pkgs, ... }: {
  # Включаем базовые графические службы Xserver
  services.xserver = {
    enable = true;
    
    # ДОБАВЛЕНО: Включаем bspwm параллельно с KDE
    windowManager.bspwm.enable = true;
  };

  # Включаем современный дисплейный менеджер SDDM (Экран входа)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; 
  };

  # Включаем графическое окружение KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Полный набор утилит для KDE и твоего хакерского BSPWM Rice
  environment.systemPackages = with pkgs; [
    # Утилиты KDE
    kdePackages.konsole
    kdePackages.kate
    
    # Утилиты BSPWM
    sxhkd
    polybar        # ИСПРАВЛЕНО: Родная панель для X11 вместо Waybar
    rofi           # Классический X11 Rofi
    dunst
    feh
    xclip
    alacritty
    gruvbox-plus-icons


  ];
}

