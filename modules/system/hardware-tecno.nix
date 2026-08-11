{ pkgs, lib, ... }: {

  # 1. ПАТЧИ ДЛЯ ЗВУКА И МИКРОФОНА (Realtek ALC269)
  # Заставляем звуковой движок принудительно искать цифровые микрофоны dmic
  boot.kernelParams = [
    "snd_vmaster_pseudo=1"
    "snd_sof_amd_renoir.dmic_acpi_check=1" # Для моделей на AMD Ryzen
    "snd_intel_dspcfg.dsp_driver=3"        # Для моделей на Intel (если кросс-платформа)
    
    # 2. ПАТЧ ЭНЕРГОСБЕРЕЖЕНИЯ И СНА (S3 / s2idle fix)
    # Принудительно включаем современный драйвер управления частотой AMD P-State
    "amd_pstate=active"
    # Решаем проблему зависания при выходе из сна
    "mem_sleep_default=deep"
  ];

  # Модули ядра, которые должны загружаться первыми для инициализации аудио-кодека
  boot.initrd.kernelModules = [ "snd_pci_acp3x" "snd_pci_acp5x" "snd_rn_pci_acp3x" ];

  # 3. НАСТРОЙКА ПОДДЕРЖКИ КЛАВИАТУРЫ И СКАНЕРА
  # Включаем udev-правила для правильной обработки горячих клавиш Fn+F1-F12
  services.udev.extraRules = ''
    # Фикс подсветки клавиатуры Tecno
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="*::kbd_backlight", ATTR{max_brightness}="3"
  '';

  # Повышаем стабильность работы встроенного Wi-Fi модуля Intel AX201/AX210
  hardware.enableAllFirmware = true;
}

