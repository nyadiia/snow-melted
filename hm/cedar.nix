{ pkgs, ... }:
{
  imports = [
    ./common.nix
    #./stylix.nix
    ./programs/discord.nix
    ./hyprland.nix
    ./programs/vscode.nix
    ./programs/parsec.nix
    ./programs/nautilus.nix
    ./ime.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    pinta
    signal-desktop

    light
    wluma
    pavucontrol

    # fonts
    noto-fonts
    noto-fonts-cjk
    inter
    roboto
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
