{ pkgs, ... }: {
  # Версия Home Manager
  home.stateVersion = "26.05"; 

  # Переносим ваши пользовательские пакеты сюда
  home.packages = with pkgs; [
    ghostty
    vlc
    steam-run
    gcc
    luarocks
     # Создаем изолированное окружение пользователя с Python и Pip
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      setuptools
    ]))
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

