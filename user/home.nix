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
      pywalfox-native
    ];
  };

  # УЛЬТИМАТИВНАЯ ДЕКЛАРАТИВНАЯ НАСТРОЙКА NEOVIM
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox-material         
      lualine-nvim             
      nvim-web-devicons        
      (nvim-treesitter.withPlugins (p: [ 
        p.nix p.lua p.bash p.python p.json p.markdown p.yaml
      ]))                      
    ];

    extraLuaConfig = ''
      vim.opt.number = true           
      vim.opt.relativenumber = true   
      vim.opt.termguicolors = true    
      vim.opt.tabstop = 4             
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true        
      vim.opt.mouse = "a"             
      vim.clipboard = "unnamedplus"   
      vim.opt.smartindent = true      
      vim.opt.wrap = false            

      vim.g.gruvbox_material_background = "medium" 
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = 1

      vim.cmd("colorscheme gruvbox-material")

      require('lualine').setup({
        options = {
          theme = 'gruvbox-material',
          component_separators = { left = '╱', right = '╱' },
          section_separators = { left = '', right = '' },
          globalstatus = true,       
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

    # ИСПРАВЛЕНО: Перевели Picom на ультра-плавный нативный бэкенд EGL для AMD Radeon
    ".config/picom/picom.conf".text = ''
      backend = "egl";
      vsync = true;

      # УЛУЧШЕННАЯ ФИЗИКА АНИМАЦИЙ
      animations = true;
      animation-stiffness = 320.0;  
      animation-dampening = 26.0;   
      animation-clamping = false;   
      animation-mass = 0.8;         

      animation-for-workspace-switch = "slide-left"; 
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "zoom";
      animation-for-transient-window = "slide-up";

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
