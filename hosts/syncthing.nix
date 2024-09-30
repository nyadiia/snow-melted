{ pkgs, lib, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "autumn";
    dataDir = "/home/autumn/share";
  };
}