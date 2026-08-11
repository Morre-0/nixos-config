{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    neovim
    fastfetch
    git
    curl
    wget
  ];

  environment.shellAliases = {
      fetch = "fastfetch"; # Короткая команда для запуска fastfetch
    nix-clean = "nix-env --delete-generations old && sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && sudo nix-collect-garbage -d && sudo nix-store --optimize && sudo nixos-rebuild boot --flake /etc/nixos/#nix-btw";
  };
}

