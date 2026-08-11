{
  description = "Конфигурация NixOS на Flakes с интеграцией Home Manager и фиксацией Hyprland v0.52.0";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ИСПРАВЛЕНО: Вынесли Hyprland v0.52.0 на правильный уровень инпутов
    hyprland.url = "github:hyprwm/Hyprland/v0.52.0";
  };

  # ИСПРАВЛЕНО: Явно передали hyprland в аргументы outputs
  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.slfhrmfn = import ./home.nix;

            # ИСПРАВЛЕНО: Добавили оверлей, который принудительно заменяет версию Hyprland во всей системе
            nixpkgs.overlays = [
              (final: prev: {
                hyprland = hyprland.packages.${prev.system}.hyprland;
              })
            ];
          }
        ];
      };
    };
  };
}

