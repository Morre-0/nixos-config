{ pkgs, ... }: {
  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        # ИСПРАВЛЕНО: Запускаем Hyprland, который при старте подхватит Noctalia
        command = "start-hyprland";
        user = "slfhrmfn";
      };
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd start-hyprland";
        user = "slfhrmfn";
      };
    };
  };
}

