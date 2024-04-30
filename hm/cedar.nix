{ pkgs, ... }:
{
  imports = [
    ./common.nix
    #./stylix.nix
    ./programs/discord.nix
    ./hyprland.nix
    ./programs/vscode.nix
    ./programs/parsec.nix
    ./ime.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    pinta

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
