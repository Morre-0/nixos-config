{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Системные пакеты (CLI-софт)
  environment.systemPackages = with pkgs; [
    alacritty
    neovim
    git
    curl
    wget
    fastfetch
  ];

  # Твоя ультимативная панель коротких команд
  environment.shellAliases = {
    # 1. Запуск fastfetch
    fetch = "fastfetch"; 
    
    # 2. Восстановленный алиас для обновления всей системы и пуша на GitHub
        nix-upgrade = "cd /etc/nixos && sudo chown -R slfhrmfn:users /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos/#nix-btw && git add . && git commit -m 'chore: авто-коммит при обновлении системы' && git push origin master";

    # 3. Глубокая очистка диска и обновление загрузчика
    nix-clean = "nix-env --delete-generations old && sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && sudo nix-collect-garbage -d && sudo nix-store --optimize && sudo nixos-rebuild boot --flake /etc/nixos/#nix-btw";
  };
}

