{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  networking.hostName = "hyprdash";
  time.timeZone = "America/Chicago";

  environment = {
    systemPackages = with pkgs; [
      sbctl
      gparted
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # TODO: this should not be needed...
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      "sudo".fprintAuth = true;
      "su".fprintAuth = true;
    };
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };

  users.users.nyadiia = {
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
      "docker"
      "libvirtd"
      "tss"
    ];
  };

  # must enable wm outside of hm
  # otherwise you cant login into it
  programs = {
    virt-manager.enable = true;
    ssh.startAgent = false;
    steam.enable = true;
    gnupg = {
      agent.enable = true;
      agent.enableSSHSupport = true;
    };
  };

  powerManagement.powertop.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    sensor.iio.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options = "terminate:ctrl_alt_bksp,compose:caps";
      };
    };
    gnome.sushi.enable = true;
    pcscd.enable = true;
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
    gvfs.enable = true;
    tumbler.enable = true;
    psd.enable = true;
    tlp = {
      enable = false;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
  };

  boot.kernelParams = [
    "nowatchdog"
  ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=60min
  '';
  services.logind.lidSwitch = "suspend-then-hibernate";

  systemd.services =
    let
      hibernateEnvironment = {
        HIBERNATE_SECONDS = "3600";
        HIBERNATE_LOCK = "/var/run/autohibernate.lock";
      };
    in
    {
      "awake-after-suspend" = {
        description = "Sets up the suspend so that it'll wake for hibernation";
        wantedBy = [ "suspend.target" ];
        before = [ "systemd-suspend.service" ];
        environment = hibernateEnvironment;
        script = ''
          if [ $(cat /sys/class/power_supply/ACAD/online) -eq 0 ]; then
            curtime=$(date +%s)
            echo "$curtime $1" >> /tmp/autohibernate.log
            echo "$curtime" > $HIBERNATE_LOCK
            ${pkgs.utillinux}/bin/rtcwake -m no -s $HIBERNATE_SECONDS
          else
            echo "System is on AC power, skipping wake-up scheduling for hibernation." >> /tmp/autohibernate.log
          fi
        '';
        serviceConfig.Type = "simple";
      };
      "hibernate-after-recovery" = {
        description = "Hibernates after a suspend recovery due to timeout";
        wantedBy = [ "suspend.target" ];
        after = [ "systemd-suspend.service" ];
        environment = hibernateEnvironment;
        script = ''
          curtime=$(date +%s)
          sustime=$(cat $HIBERNATE_LOCK)
          rm $HIBERNATE_LOCK
          if [ $(($curtime - $sustime)) -ge $HIBERNATE_SECONDS ] ; then
            systemctl hibernate
          else
            ${pkgs.utillinux}/bin/rtcwake -m no -s 1
          fi
        '';
        serviceConfig.Type = "simple";
      };
    };
}
