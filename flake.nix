{
  description = "NixOS Unstable — Полный BSPWM Rice в стиле Gruvbox Material с раздельными капсулами";

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

    picom-pijulius = {
      url = "github:pijulius/picom";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, zen-browser, picom-pijulius, ... }@inputs: {
    nixosConfigurations = {
      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./configuration.nix
          disko.nixosModules.disko

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # Настройка автоматического бэкапа конфликтующих файлов
            home-manager.backupFileExtension = "backup";
            
            home-manager.users.slfhrmfn = import ./user/home.nix inputs;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
  };
}
