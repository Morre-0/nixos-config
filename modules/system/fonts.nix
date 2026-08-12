{ pkgs, ... }: {
  # Системная установка шрифтов под требования NixOS Unstable
  fonts.packages = with pkgs; [
    # Твой основной шрифт для кода и терминала с иконками
    nerd-fonts.jetbrains-mono
    
    # ПРИНУДИТЕЛЬНО: Ставим чистый пак символов и иконок для Polybar
    nerd-fonts.symbols-only

    # Базовые системные шрифты для отображения сайтов и интерфейсов
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    
    # Пакет шрифтов MS (Arial, Times New Roman, Comic Sans)
    corefonts
  ];

  # Включаем сглаживание и оптимизацию отображения
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
    };
  };
}

