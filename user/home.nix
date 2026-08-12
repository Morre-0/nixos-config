inputs: { pkgs, ... }: {
  home.stateVersion = "26.05"; 

  # Пакеты пользователя (чистый GNOME Workstation)
  home.packages = with pkgs; [
    btop
    htop
    cmus
    vlc
    steam-run
    gcc
    luarocks
    pywalfox-native
    
    # Твой браузер Zen Browser из внешнего флейка
    inputs.zen-browser.packages."${pkgs.system}".default

    # Изолированное окружение Python
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
      pywalfox-native
    ];
  };

  # Декларативная настройка встроенного Vim
  programs.vim = {
    enable = true;
    settings = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };
    extraConfig = ''
      syntax on
      set mouse=a
      set clipboard=unnamedplus
    '';
  };

  programs.home-manager.enable = true;
  home.file = {
    ".config/scripts" = { source = ./dotfiles/scripts; recursive = true; executable = true; };
    ".config/alacritty" = { source = ./dotfiles/alacritty; recursive = true; };
    ".config/polybar" = { source = ./dotfiles/polybar; recursive = true; };
  };

}
