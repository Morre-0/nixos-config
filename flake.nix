{
  description = "Конфигурация NixOS на Flakes с интеграцией Home Manager";

  inputs = {
    # Стабильная ветка пакетов NixOS 26.05
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Стабильная ветка Home Manager для версии 26.05
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Синхронизируем версии пакетов
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          # Подключаем модуль Home Manager к системе
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # Настройки для вашего конкретного пользователя
            home-manager.users.slfhrmfn = { pkgs, ... }: {
              # Обязательный параметр состояния для HM
              home.stateVersion = "26.05"; 

              # Здесь будут декларативные настройки ваших программ!
              # Например, настройки для Ghostty:
              programs.ghostty = {
                enable = true;
                settings = {
                  font-family = "JetBrainsMono Nerd Font";
                  font-size = 11;
                  background-opacity = 0.9;
                };
              };
            };
          }
        ];
      };
    };
  };
}

