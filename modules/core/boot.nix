{ pkgs, ... }: {
  # Загрузчик systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.supportedFilesystems = [ "btrfs" ];

  # ИСПРАВЛЕНО: Принудительно переключаем систему на последнее mainline-ядро Linux
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

