{ pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "juniper";

  time.timeZone = "America/Chicago";

  users.users.autumn = {
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
    ];
  };

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

  # see nixos-hardware
  hardware.raspberry-pi."4" = {
    audio.enable = true;
    bluetooth.enable = true;
  };

  hardware.pulseaudio.enable = lib.mkForce false;

  services = {
    # isn't it funny that this is called xserver, but i'm running wayland
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "10-disable-camera" = {
            "wireplumber.profiles" = {
              main."monitor.libcamera" = "disabled";
            };
          };
        };
      };
    };
  };
}