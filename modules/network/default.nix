{ ... }: {
  networking.hostName = "nix-btw";
  networking.networkmanager.enable = true;

  # Разрешаем несвободные пакеты на уровне сетевых утилит и Steam
  nixpkgs.config.allowUnfree = true;

  # Декларативные правила безопасности для Git
  programs.git = {
    enable = true;
    config.safe.directory = "/etc/nixos";
  };
}

