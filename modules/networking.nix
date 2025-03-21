{
  networking.networkmanager.enable = true;

  systemd.services.NetworkManager.wantedBy = [ "multi-user.target" ];
}
