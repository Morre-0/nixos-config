{ pkgs, ... }: {
  # Системная установка шрифтов под требования актуальной ветки NixOS Unstable
  fonts.packages = with pkgs; [
    # Главные шрифты сетапа Peyrzival
    nerd-fonts.space-mono         
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only       # Включает в себя Feather, Material и FontAwesome иконки

    # Базовые системные шрифты
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    corefonts
  ];

  # Включаем сглаживание и оптимизацию отображения
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "SpaceMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
    };
  };
}
