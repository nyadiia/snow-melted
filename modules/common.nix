# common configuration for all systems
# anything you want to be assumed to be installed should be in here!

{ pkgs, ... }:
{
  # enable networking
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libGL
      harfbuzz
      xorg.libX11
      glib
      fuse3
      fuse
      SDL2
      libpng
      libzip
      tinyxml-2
      spdlog
    ];
  };

  # common packages
  # most things should be in home-manager, this is for system packages
  environment.systemPackages = with pkgs; [
    exfatprogs
    git
    killall
    zip
    unzip
    tealdeer
    fd
    btop
    tmux
    wget
    curl
    ripgrep
  ];
  environment.variables.EDITOR = "nvim";

  # default user account
  users.users.nyadiia = {
    isNormalUser = true;
    description = "nyadiia";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # for systems that don't use home-manager (like servers)
    shell = pkgs.fish;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    # Enable virtualization
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  services = {
    chrony.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    system76-scheduler.enable = true;
  };

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    builders-use-substitutes = true;
    substituters = [
      "https://cache.garnix.io"
    ];

    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  programs = {
    fish = {
      enable = true;
      shellAliases = {
        la = "ls -la";
      };
    };
    gnupg.agent.enable = true;
    dconf.enable = true;
    command-not-found.enable = false;
    nix-index.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3 --nogcroots";
      flake = "/home/nyadiia/snow";
    };
  };

  # i18n
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  home-manager.backupFileExtension = "backup";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
