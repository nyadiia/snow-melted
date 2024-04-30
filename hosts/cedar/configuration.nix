# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-9c14cd26-683d-49f6-bd6f-90f5cf15d54a".device = "/dev/disk/by-uuid/9c14cd26-683d-49f6-bd6f-90f5cf15d54a";

  networking.hostName = "cedar";

  time.timeZone = "America/Chicago";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    # pam.services = {
    #   "sudo".fprintAuth = true;
    #   "su".fprintAuth = true;
    # };
  };

  users.users.autumn = {
    extraGroups = [ "networkmanager" "video" "wheel" "docker" ];
  };

  # must enable wm outside of hm
  # otherwise you cant login into it
  programs.hyprland.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # TODO: this should not be needed...
    GTK_IM_MODULE="fcitx";
    QT_IM_MODULE="fcitx";
    XMODIFIERS="@im=fcitx";
  };

  powerManagement.powertop.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";

    # prevent spam on screen
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks -r --cmd Hyprland";
        user = "greeter";
      };
    };

    fwupd.enable = true;
    thermald.enable = true;
    upower.enable = true;
    printing.enable = true;
    colord.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    gvfs.enable = true;
    tumbler.enable = true;
    psd.enable = true;
  };

  boot.kernelParams = [
    "mem_sleep_default=deep"
    "nowatchdog"
  ];
}
