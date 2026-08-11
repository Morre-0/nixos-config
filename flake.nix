{
  description = "Чистая конфигурация NixOS на актуальной ветке unstable с подготовленным Disko";

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
          
          # Загружаем сам модуль Disko, чтобы он прописался в системе...
          disko.nixosModules.disko
          # ...НО саму разметку ./disko-config.nix здесь НЕ импортируем,
          # чтобы не было конфликта с твоим текущим диском!
          
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
