{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./programs/discord.nix
    ./hyprland.nix
    ./programs/vscode.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    light
    wluma
    pavucontrol
    iio-sensor-proxy

    # fonts
    noto-fonts
    noto-fonts-cjk
    inter
    roboto
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
