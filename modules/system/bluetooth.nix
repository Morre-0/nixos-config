{ pkgs, ... }: {
  # Включаем Bluetooth-адаптер на системном уровне
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Автоматически включать Bluetooth при старте ПК
    settings = {
      General = {
        Experimental = true; # Включает поддержку отображения заряда батареи наушников
      };
    };
  };

  # Включаем графический менеджер Bluetooth (Blueman), который заменяет удаленный Blueberry
  services.blueman.enable = true;
}

