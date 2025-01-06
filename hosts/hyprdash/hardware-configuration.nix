{ pkgs, inputs, ... }:
{
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9c14cd26-683d-49f6-bd6f-90f5cf15d54a".device = "/dev/disk/by-uuid/9c14cd26-683d-49f6-bd6f-90f5cf15d54a";
}