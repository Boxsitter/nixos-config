{ pkgs, ... }:

{
  users.users.leyton = {
    isNormalUser = true;
    description = "Leyton Houck";
    home = "/home/leyton";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
    initialPassword = "7574"; # remember to change this or switch to hashedPassword
  };

  services.getty.autologinUser = "leyton";
}
