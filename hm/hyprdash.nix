{ pkgs, style, ... }:
{
  imports = [
    ./common.nix
    ./gnome.nix
    ./programs/discord.nix
    ./programs/vscode.nix
    ./programs/nvim.nix
    ./programs/parsec.nix
    ./programs/nautilus.nix
    ./programs/zen-browser.nix
    ./ime.nix
    ./xcompose.nix
  ];

  home = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    packages =
      style.fonts.font-packages
      ++ (with pkgs; [
        qbittorrent
        gnome-power-manager
        shipwright
        signal-desktop
        ghostty

        spotify

        light
        wluma
        pavucontrol

        # fonts
        noto-fonts
        noto-fonts-cjk-sans
        inter

        fira

        obsidian
        inkscape
      ]);
  };

  programs = {
    firefox.enable = true;
  };

  fonts.fontconfig.enable = true;
}
