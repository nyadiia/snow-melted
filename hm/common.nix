{ pkgs, ... }:
{
  imports = [
    ./shell
    ./programs/ssh.nix
    ./programs/git.nix
    ./programs/gpg.nix
  ];

  home.username = "autumn";
  home.homeDirectory = "/home/autumn";

  systemd.user.startServices = "sd-switch";
  home = {
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
