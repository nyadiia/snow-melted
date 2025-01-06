{ pkgs, lib, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "nyadiia";
    dataDir = "/home/nyadiia/share";
  };
}