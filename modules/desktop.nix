{ pkgs, ... }: {
  # Включаем Hyprland на системном уровне
  programs.hyprland.enable = true;

  # Настраиваем по-настоящему автоматический вход в систему
  services.greetd = {
    enable = true;
    settings = {
      # Первая сессия при старте ПК — мгновенный чистый вход
      initial_session = {
        # ИСПРАВЛЕНО: Используем официальный стартер вместо прямого вызова
        command = "start-hyprland";
        user = "slfhrmfn";
      };
      # Запасной текстовый вход на случай выхода из сессии
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd start-hyprland";
        user = "slfhrmfn";
      };
    };
  };
}

