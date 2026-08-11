{ pkgs, ... }: {

  # 1. ПАТЧИ ЯДРА И ПЕРЕМЕННЫЕ ДЛЯ АППАРАТНОГО УСКОРЕНИЯ AMD
  boot.kernelParams = [
    "snd_vmaster_pseudo=1"
    "snd_sof_amd_renoir.dmic_acpi_check=1"
    "amd_pstate=active"
    "mem_sleep_default=deep"
    
    # ИСПРАВЛЕНО: Убираем микрофризы графики AMD (отключаем агрессивный сон GPU)
    "amdgpu.dcfeaturemask=0x2" 
    # Включаем принудительную привязку к частоте экрана (убирает разрывы кадров)
    "amdgpu.freesync_video=1"
  ];

  # Гарантируем раннюю загрузку драйвера видеокарты для плавного старта GDM
  boot.initrd.kernelModules = [ "amdgpu" "snd_pci_acp3x" "snd_pci_acp5x" "snd_rn_pci_acp3x" ];

  # 2. ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ ДЛЯ ПЛАВНОСТИ GNOME WAYLAND
  environment.variables = {
    # Включаем аппаратное ускорение рендеринга интерфейса через OpenGL
    "CLUTTER_BACKEND" = "wayland";
    # Активируем встроенный в GNOME механизм тройной буферизации для устранения просадок FPS
    "MUTTER_DEBUG_ENABLE_TRIPLE_BUFFERING" = "1";
  };

  # Правила для клавиатуры и лимитов яркости
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*::kbd_backlight", ATTR{max_brightness}="3"
  '';

  hardware.enableAllFirmware = true;
}

