{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    initrd = {
      systemd.enable = true;
      services.lvm.enable = true;
      luks.devices."enc-pv" = {
        device = "/dev/disk/by-uuid/c2c26fe4-5bc5-48c3-b247-b635327bf513";
      };
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
        "aesni_intel"
        "cryptd"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    kernelParams = [
      "resume=UUID=f65d74ec-ddd3-44af-91da-c8c93e4ee897"
      "nowatchdog"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    supportedFilesystems = [ "f2fs" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/a19ebd73-73c9-4dbf-b6db-bc2d14ae7cff";
      fsType = "f2fs";
      options = [
        "compress_algorithm=lz4"
        "compress_chksum"
        "atgc"
        "gc_merge"
        "lazytime"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BDAC-3876";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/f65d74ec-ddd3-44af-91da-c8c93e4ee897"; }
  ];
  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
