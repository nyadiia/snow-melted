# common configuration for all systems
# anything you want to be assumed to be installed should be in here!

{ pkgs, ... }:
{
  # enable networking
  networking.networkmanager.enable = true;

  # common packages
  # most things should be in home-manager, this is for system packages 
  environment.systemPackages = with pkgs; [
    git
    neovim
    killall
    zip
    unzip
    tealdeer
  ];
  environment.variables.EDITOR = "nvim";

  # default user account
  users.users.autumn = {
    isNormalUser = true;
    description = "Autumn";
    extraGroups = [ "networkmanager" "wheel" ];
    # for systems that don't use home-manager (like servers)
    shell = pkgs.fish;
  };

  # nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    builders-use-substitutes = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
      "https://walker.cachix.org"
      "https://cache.garnix.io"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
  # not needed with nh
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 30d";
  # };

  programs = {
    fish = {
      enable = true;
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      shellAliases = {
        la = "ls -la";
      };
    };
    gnupg.agent.enable = true;
    dconf.enable = true;
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = false;
      enableBashIntegration = false;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
      flake = "/home/autumn/snow";
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
