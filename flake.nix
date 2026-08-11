{
  description = "Конфигурация NixOS на Flakes с фиксацией стабильного Hyprland v0.52.0 через срез Nixpkgs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Подключаем стабильный архив nixpkgs, в котором поставлялся Hyprland v0.52.0
    nixpkgs-hyprland.url = "github:nixos/nixpkgs/cb9a94da7e72280628e9324e93d843a08ee00eb0";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-hyprland, ... }@inputs: 
  let
    system = "x86_64-linux";
    # Инициализируем пакеты старого среза для архитектуры твоего ПК
    pkgs-old = import nixpkgs-hyprland { inherit system; config.allowUnfree = true; };
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

            # ИСПРАВЛЕНО: Этот оверлей чисто подменяет бинарник, порталы и сессии GDM
            # на эталонную версию 0.52.0, которая запустит твой .conf файл
            nixpkgs.overlays = [
              (final: prev: {
                hyprland = pkgs-old.hyprland;
                xdg-desktop-portal-hyprland = pkgs-old.xdg-desktop-portal-hyprland;
              })
            ];
          }
        ];
      };
    };
  };
}

