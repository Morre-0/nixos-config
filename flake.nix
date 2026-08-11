{
  description = "Чистая конфигурация NixOS на актуальной ветке unstable с поддержкой Disko и Zen Browser";

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, zen-browser, ... }@inputs: {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          # Загружаем сам модуль Disko, чтобы система знала эти команды...
          disko.nixosModules.disko
          # ...НО саму разметку ./disk/disko-config.nix здесь НЕ импортируем,
          # чтобы не было конфликта с твоим текущим диском!

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            home-manager.users.slfhrmfn = import ./user/home.nix inputs;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
