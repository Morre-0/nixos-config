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
    nativeMessagingHosts = with pkgs; [
      pywalfox-native # Нативный мост для автопокраски шапки Firefox
    ];
  };

  # УЛЬТИМАТИВНАЯ ДЕКЛАРАТИВНАЯ НАСТРОЙКА NEOVIM
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-material         # Наша основная тема
      lualine-nvim             # Красивая статус-строка внизу
      nvim-web-devicons        # Иконки для статус-строки и平лагинов
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

    # ДОБАВЛЕНО: Ультра-плавные и упругие анимации picom-pijulius
    ".config/picom/picom.conf".text = ''
      backend = "glx";
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      vsync = true;

      # УЛУЧШЕННАЯ ФИЗИКА АНИМАЦИЙ
      animations = true;
      animation-stiffness = 320.0;  # Быстрый и резкий старт окон
      animation-dampening = 26.0;   # Упругий, приятный эффект отскока (bounce)
      animation-clamping = false;   # Окна мягко пружинят в конце анимации
      animation-mass = 0.8;         # Облегченный вес окон для моментального отклика

      # Настройки эффектов переключения
      animation-for-workspace-switch = "slide-left"; 
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "zoom";
      animation-for-transient-window = "slide-up";

      # ЭФФЕКТЫ РАЗМЫТИЯ И ТЕНИ GRUVBOX
      shadow = true;
      shadow-radius = 12;
      shadow-offset-x = -12;
      shadow-offset-y = -12;
      shadow-opacity = 0.4;
      shadow-color = "#1e1e1e";

      blur: {
        method = "dual_kawase";
        strength = 6;
        background = true;
      }

      opacity-rule = [
        "92:class_g = 'Alacritty'",
        "95:class_g = 'Rofi'"
      ];

      wintypes: {
        tooltip = { fade = true; shadow = true; opacity = 0.85; focus = true; };
        dock = { shadow = true; }
      };
    '';
  };

  programs.home-manager.enable = true;
}
