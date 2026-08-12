{ pkgs, inputs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; 
  };

  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.konsole
    kdePackages.kate
    
    sxhkd
    polybar        
    rofi           
    dunst
    feh
    xclip
    alacritty      
    gruvbox-plus-icons
    brightnessctl  # ИСПРАВЛЕНО: Современная утилита яркости экрана

    inputs.picom-pijulius.packages."${pkgs.system}".default
  ];
}

