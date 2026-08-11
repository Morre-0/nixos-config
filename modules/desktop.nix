{ pkgs, ... }: {
  # Включаем Hyprland на системном уровне
  programs.hyprland.enable = true;

  # Автоматический вход в систему без экранных менеджеров
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        user = "slfhrmfn";
      };
    };
  };

  # Настройка звука (Pipewire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}

