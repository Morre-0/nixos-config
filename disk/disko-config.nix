{
  disko.devices = {
    disk = {
      # Настраиваем конкретно диск nvme1n1
      main = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            # 1. Открытый загрузочный раздел EFI (1 Гигабайт, как в lsblk)
            ESP = {
              priority = 1;
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            # 2. Зашифрованный LUKS-контейнер для Btrfs (467.1 Гигабайт)
            luks = {
              size = "467.1G";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    # Корень системы (/)
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    # Домашние папки (/home)
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    # Хранилище пакетов (/nix)
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                  };
                };
              };
            };
            # 3. Раздел подкачки Swap (8.8 Гигабайт, как в lsblk)
            swap = {
              size = "8.8G";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };
          };
        };
      };
    };
  };
}

