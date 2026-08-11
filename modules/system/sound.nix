{ ... }: {
  # Системная служба реального времени для приоритета аудиопотоков
  security.rtkit.enable = true;

  # Настройка звукового сервера Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}

