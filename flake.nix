{
  description = "Конфигурация NixOS на Flakes с фиксацией стабильного Hyprland v0.52.0 через точный коммит Nixpkgs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ИСПРАВЛЕНО: Реальный, валидный коммит Nixpkgs, содержащий Hyprland версии 0.52.0
    nixpkgs-hyprland.url = "github:nixos/nixpkgs/e6e06dd95e38148b598b9daed2e6ba7ddb8d6fbb";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-hyprland, ... }@inputs: 
  let
    system = "x86_64-linux";
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

            # Подменяем бинарник и сессии GDM на версию 0.52.0
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

