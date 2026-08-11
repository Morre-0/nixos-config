{ pkgs, ... }: {
  # Настройка шрифтов под требования NixOS Unstable
  fonts.packages = with pkgs; [
    # Твой основной шрифт для терминала и кода с иконками Nerd Font
    nerd-fonts.jetbrains-mono
    
    # Пакет с Comic Sans и другими шрифтами MS (Arial, Times New Roman)
    corefonts

    # Базовые системные шрифты для отображения интерфейсов
    noto-fonts
    noto-fonts-cjk-sans
    # ИСПРАВЛЕНО: Актуальное имя пакета в unstable ветке
    noto-fonts-color-emoji
  ];

  # Включаем базовое сглаживание и оптимизацию отображения
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
    };
  };
}

