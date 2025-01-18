{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source
    '';
    shellInit = ''
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
    shellAliases = {
      la = "eza la";
      code = "codium";
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
    icons = "auto";
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
