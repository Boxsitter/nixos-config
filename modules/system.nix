{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us";
}
