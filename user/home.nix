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

  # УЛЬТИМАТИВНАЯ ДЕКЛАРАТИВНАЯ НАСТРОЙКА NEOVIM (ИСПРАВЛЕНО ПОД NEW TREESITTER)
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-material         # Наша основная тема
      lualine-nvim             # Красивая статус-строка внизу
      nvim-web-devicons        # Иконки для статус-строки и плагинов
      (nvim-treesitter.withPlugins (p: [ 
        p.nix p.lua p.bash p.python p.json p.markdown p.yaml
      ]))                      # Мощная TrueColor подсветка синтаксиса
    ];

    extraLuaConfig = ''
      -- 1. Системные настройки интерфейса
      vim.opt.number = true           -- Включаем нумерацию строк
      vim.opt.relativenumber = true   -- Включаем относительные номера строк
      vim.opt.termguicolors = true    -- Включаем 24-битные TrueColor цвета
      vim.opt.tabstop = 4             -- Размер табуляции (4 пробела)
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true        -- Превращать табы в пробелы
      vim.opt.mouse = "a"             -- Включаем поддержку мыши
      vim.clipboard = "unnamedplus"   -- Общий буфер обмена с системой (xclip)
      vim.opt.smartindent = true      -- Умные автоотступы при вводе кода
      vim.opt.wrap = false            -- Не переносить длинные строки автоматически

      -- 2. Настройка палитры Gruvbox Material
      vim.g.gruvbox_material_background = "medium" -- Варианты: 'hard', 'medium', 'soft'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = 1

      -- 3. Активируем тему оформления
      vim.cmd("colorscheme gruvbox-material")

      -- 4. Настройка статус-строки Lualine под тему Gruvbox
      require('lualine').setup({
        options = {
          theme = 'gruvbox-material',
          component_separators = { left = '╱', right = '╱' },
          section_separators = { left = '', right = '' },
          globalstatus = true,       -- Одна монолитная строка внизу экрана
        }
      })

      -- ИСПРАВЛЕНО: Старый require('nvim-treesitter.configs').setup удален,
      -- так как новый Treesitter в NixOS инициализируется автоматически.
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
