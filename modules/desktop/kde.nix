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
    sxhkd          # Демон горячих клавиш (БЕЗ НЕГО ХОТКЕИ НЕ РАБОТАЮТ)
    rofi           # Меню запуска приложений
    alacritty      # Терминал для хоткея
    feh            # Установка обоев рабочего стола
    xclip          # Буфер обмена
  ];
}

