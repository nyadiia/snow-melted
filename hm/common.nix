{ config, pkgs, ... }:
{
  imports = [
    ./shell
    ./programs/ssh.nix
    ./programs/git.nix
    ./programs/gpg.nix
  ];

  home.username = "nyadiia";
  home.homeDirectory = "/home/nyadiia";

  systemd.user.startServices = "sd-switch";
  home = {
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;

  # xdg.userDirs = {
  #   enable = true;
  #   music = "${config.home.homeDirectory}/music";
  #   pictures = "${config.home.homeDirectory}/pictures";
  #   videos = "${config.home.homeDirectory}/videos";
  #   download = "${config.home.homeDirectory}/downloads";
  #   documents = "${config.home.homeDirectory}/documents";
  #   publicShare = "${config.home.homeDirectory}/public";
  # };
}
