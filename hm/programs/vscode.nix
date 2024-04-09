{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
  ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      jnoortheen.nix-ide
      tamasfe.even-better-toml
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
    };
  };
}
