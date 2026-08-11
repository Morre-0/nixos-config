{ ... }: {
  users.users.slfhrmfn = {
    isNormalUser = true;
    description = "slfhrmfn";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };
}

