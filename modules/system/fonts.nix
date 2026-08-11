{ pkgs, ... }: {
  # Настройка шрифтов под требования NixOS Unstable
  fonts.packages = with pkgs; [
    # Твой основной шрифт для терминала и кода с иконками Nerd Font
    nerd-fonts.jetbrains-mono
    
    # ДОБАВЛЕНО: Пакет с Comic Sans и другими шрифтами MS (Arial, Times New Roman)
    corefonts

    # Базовые системные шрифты для отображения интерфейсов
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
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

