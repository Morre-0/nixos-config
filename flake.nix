{
  description = "Конфигурация NixOS на Flakes с фиксацией стабильного Hyprland без Lua из ветки 24.11";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ИСПРАВЛЕНО: Подключаем официальную стабильную ветку, где Hyprland работает строго на классических .conf файлах
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-stable, ... }@inputs: 
  let
    system = "x86_64-linux";
    # Инициализируем стабильные пакеты без Lua
    pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
  in {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.slfhrmfn = import ./home.nix;

            # ИСПРАВЛЕНО: Этот оверлей подменяет бинарник и порталы сессии на версию из ветки 24.11.
            # Она никогда не выдаст 404, а GDM сразу увидит .desktop файл запуска.
            nixpkgs.overlays = [
              (final: prev: {
                hyprland = pkgs-stable.hyprland;
                xdg-desktop-portal-hyprland = pkgs-stable.xdg-desktop-portal-hyprland;
              })
            ];
          }
        ];
      };
    };
  };
}

