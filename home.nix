{ pkgs, ... }: {
  # Версия Home Manager (оставляем ту, что была)
  home.stateVersion = "26.05"; 

  # Переносим ваши пользовательские пакеты сюда
  home.packages = with pkgs; [
    ghostty
    vlc
  ];

  # Конфигурация Ghostty через Home Manager
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;
      background-opacity = 0.9;
    };
  };

  # Разрешаем Home Manager управлять самим собой
  programs.home-manager.enable = true;
}

