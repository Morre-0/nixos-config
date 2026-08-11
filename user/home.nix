inputs: { pkgs, ... }: {
  home.stateVersion = "26.05"; 

  home.packages = with pkgs; [
    alacritty
    btop
    htop
    cmus
    vlc
    steam-run
    gcc
    luarocks
    pywalfox-native

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
      pywalfox-native
    ];
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Декларативная настройка Vim
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
      set ignorecase
      set smartcase
    '';
  };

  programs.home-manager.enable = true;
}

