{ pkgs, style, ... }:
{
  imports = [
    ./common.nix
    ./gnome.nix
    ./programs/discord.nix
    ./hyprland.nix
    ./programs/vscode.nix
    ./programs/parsec.nix
    ./programs/nautilus.nix
    ./ime.nix
    ./xcompose.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = style.fonts.font-packages ++ (with pkgs; [
    signal-desktop

    spotify

    light
    wluma
    pavucontrol

    # fonts
    noto-fonts
    noto-fonts-cjk
    inter

    fira

    obsidian
    inkscape
  ]);
}
