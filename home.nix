{ pkgs, ... }: {
  # Версия Home Manager
  home.stateVersion = "26.05"; 

  # Автоматически скачиваем NvChad и копируем файлы по-настоящему (для записи)
  xdg.configFile."nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "Morre-0";
      repo = "nvchad-config";
      rev = "master"; 
      sha256 = "sha256-Dxg7vo5KdfB6eemTfoZy1UmC1i3dfGWsJBirExehdps=";
    };
    # Этот флаг в xdg.configFile копирует файлы как обычные (writable), а не как read-only ссылки
    recursive = true;
  };

  # Переносим ваши пользовательские пакеты сюда
  home.packages = with pkgs; [
    ghostty
    vlc
    steam-run
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

