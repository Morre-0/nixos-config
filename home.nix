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

  # Декларативная настройка Vim
  programs.vim = {
    enable = true;
    
    # Включаем базовые удобства
    settings = {
      number = true;         # Показывать номера строк
      relativenumber = false; # Отключаем относительные номера
      tabstop = 4;           # Размер табуляции (4 пробела)
      shiftwidth = 4;        # Размер отступа при автосдвиге
      expandtab = true;      # Конвертировать табы в пробелы
    };

    # Дополнительные команды для файла .vimrc
    extraConfig = ''
      syntax on              " Включить подсветку синтаксиса
      set mouse=a            " Разрешить работу мышкой (выделение, скролл)
      set clipboard=unnamedplus " Системный буфер обмена (Ctrl+C / Ctrl+V)
      set ignorecase         " Игнорировать регистр при поиске
      set smartcase          " Но учитывать регистр, если есть заглавная буква
      
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

