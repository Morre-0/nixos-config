{ pkgs, ... }: {
  # Версия Home Manager
  home.stateVersion = "26.05"; 

  # Пользовательские пакеты
  home.packages = with pkgs; [
    ghostty
    btop
    htop
    cmus
    vlc
    steam-run
    gcc
    luarocks
    
    # ИСПРАВЛЕНО: Добавляем сам пакет pywalfox в систему
    pywalfox

    # Изолированное окружение пользователя с Python и Pip
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      setuptools
    ]))
  ];

  # Настройка Firefox с поддержкой Pywalfox
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      pywalfox
    ];
  };

  # Добавление локальной бинарной папки в PATH
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Декларативная настройка Vim
  programs.vim = {
    enable = true;
    
    settings = {
      number = true;         # Показывать номера строк
      relativenumber = true; # Относительные номера строк
      tabstop = 4;           # Размер табуляции (4 пробела)
      shiftwidth = 4;        # Размер отступа при автосдвиге
      expandtab = true;      # Конвертировать табы в пробелы
    };

    extraConfig = ''
      syntax on              " Включить подсветку синтаксиса
      set mouse=a            " Разрешить работу мышкой (выделение, скролл)
      set clipboard=unnamedplus " Системный буфер обмена (Ctrl+C / Ctrl+V)
      set ignorecase         " Игнорировать регистр при поиске
      set smartcase          " Но учитывать регистр, если есть заглавная буква
    '';
  };

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

