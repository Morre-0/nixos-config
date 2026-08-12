{ pkgs, inputs, ... }: {
  # Включаем графический сервер X11
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
  };

  # Включаем дисплейный менеджер SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; 
  };

  # Включаем графическое окружение KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Полный набор утилит для KDE и твоего хакерского BSPWM Rice
  environment.systemPackages = with pkgs; [
    kdePackages.konsole
    kdePackages.kate
    
    # Экосистема для BSPWM Rice
    sxhkd
    polybar        
    rofi           
    dunst
    feh
    xclip
    alacritty      
    gruvbox-plus-icons

    # ИСПРАВЛЕНО: Устанавливаем форк pijulius глобально для всей системы
    inputs.picom-pijulius.packages."${pkgs.system}".default
  ];
}

