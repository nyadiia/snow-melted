{ pkgs, lib, ... }:
{
  networking.hostName = "juniper";

  time.timeZone = "America/Chicago";

  users.users.autumn = {
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  home-manager.backupFileExtension = ".bak";
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
  hardware = {
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };

    raspberry-pi."4" = {
      # NixOS/nixos-hardware#703
      # audio.enable = true;
      bluetooth.enable = true;
      fkms-3d.enable = true;
      apply-overlays-dtmerge.enable = true;
    };

    pulseaudio.enable = lib.mkForce false;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

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
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
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