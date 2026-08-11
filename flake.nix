{
  description = "Чистая конфигурация NixOS на актуальной ветке unstable с поддержкой Disko";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }@inputs: {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          
          # Подключаем модуль Disko и файл разметки
          disko.nixosModules.disko
          ./disko-config.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.slfhrmfn = import ./home.nix;
          }
        ];
      };
    };
  };
}
