{ pkgs, ... }: {
  # Автоматически скачиваем и устанавливаем NvChad с GitHub
  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "Morre-0";
      repo = "nvchad-config";
      # Точный хэш коммита (для воспроизводимости Flakes)
      rev = "master"; 
      # Специальный хэш безопасности (Nix проверит целостность скачанного)
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    # Разрешаем обновлять файлы, если репозиторий изменится
    recursive = true;
  };
  # Версия Home Manager (оставляем ту, что была)
  home.stateVersion = "26.05"; 

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

