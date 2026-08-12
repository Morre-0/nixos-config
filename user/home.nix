inputs: { pkgs, ... }: {
  home.stateVersion = "26.05"; 

  home.packages = with pkgs; [
    btop htop cmus vlc steam-run gcc luarocks pywalfox-native
    inputs.zen-browser.packages."${pkgs.system}".default
    inputs.picom-pijulius.packages."${pkgs.system}".default
    (python3.withPackages (ps: with ps; [ pip virtualenv setuptools ]))
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [ pywalfox-native ];
  };

  # УЛЬТИМАТИВНАЯ ДЕКЛАРАТИВНАЯ НАСТРОЙКА NEOVIM (GRUVBOX MATERIAL)
  programs.neovim = {
    enable = true;
    defaultEditor = true; # Делаем Neovim стандартным редактором в системе
    viAlias = true;
    vimAlias = true;

    # Устанавливаем тему напрямую через Nix пакетом
    plugins = with pkgs.vimPlugins; [
      gruvbox-material
    ];

    # Конфигурация редактора на чистом Lua
    extraLuaConfig = ''
      -- 1. Системные настройки интерфейса
      vim.opt.number = true           -- Включаем нумерацию строк
      vim.opt.relativenumber = true   -- Включаем относительные номера строк (удобно для навигации)
      vim.opt.termguicolors = true    -- Включаем 24-битные TrueColor цвета (критично для Gruvbox)
      vim.opt.tabstop = 4             -- Размер табуляции (4 пробела)
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true        -- Превращать табы в пробелы
      vim.opt.mouse = "a"             -- Включаем поддержку мыши
      vim.clipboard = "unnamedplus"   -- Общий буфер обмена с системой (X11/xclip)

      -- 2. Настройка палитры Gruvbox Material
      vim.g.gruvbox_material_background = "medium" -- Варианты: 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_better_performance = 1

      -- 3. Активируем тему оформления
      vim.cmd("colorscheme gruvbox-material")
    '';
  };

  # Твои папки автоматического развертывания
  home.file = {
    "Pictures/Wallpapers" = { source = ./dotfiles/wallpapers; recursive = true; };
    ".config/scripts" = { source = ./dotfiles/scripts; recursive = true; executable = true; };
    ".config/alacritty" = { source = ./dotfiles/alacritty; recursive = true; };
    ".config/polybar" = { source = ./dotfiles/polybar; recursive = true; };
    ".config/sxhkd" = { source = ./dotfiles/sxhkd; recursive = true; };
    ".config/bspwm" = { source = ./dotfiles/bspwm; recursive = true; executable = true; };
  };

  programs.home-manager.enable = true;
}

