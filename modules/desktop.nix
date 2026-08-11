{ pkgs, ... }: {
  # Включаем Hyprland на системном уровне
  programs.hyprland.enable = true;

  # Настраиваем по-настоящему автоматический вход в систему
  services.greetd = {
    enable = true;
    settings = {
      # 1. Первая сессия при загрузке — заходим сразу без пароля
      initial_session = {
        command = "Hyprland";
        user = "slfhrmfn";
      };
      # 2. Если ты случайно выйдешь из Hyprland, тебя вернет в текстовый вход
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd Hyprland";
        user = "slfhrmfn";
      };
    };
  };
}

