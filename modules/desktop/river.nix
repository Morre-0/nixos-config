{ pkgs, ... }: {
  # Включаем оконный менеджер River
  programs.river.enable = true;

  # Настраиваем автоматический вход без экранных менеджеров прямо в River
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        # Запускаем чистую сессию River через dbus
        command = "${pkgs.dbus}/bin/dbus-run-session river";
        user = "slfhrmfn";
      };
      default_session = {
        # ИСПРАВЛЕНО: Прямая ссылка на пакет greetd
        command = "${pkgs.greetd}/bin/agreety --cmd river";
        user = "slfhrmfn";
      };
    };
  };
}

