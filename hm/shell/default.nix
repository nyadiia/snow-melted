{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source
    '';
    shellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      la = "eza la";
      c = "code . && exit";
    };
  };
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
