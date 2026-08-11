{ pkgs, ... }: {
  # Включаем Hyprland на системном уровне
  programs.hyprland.enable = true;

  # Автоматический вход в систему без экранных менеджеров
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd Hyprland";
        user = "slfhrmfn";
      };
    };
  };
}

