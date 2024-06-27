{ pkgs, ... }:
{
  imports = [
    ./vscode/theme.nix
  ];
  home.packages = with pkgs; [
    nil
  ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      rust-lang.rust-analyzer
      ms-azuretools.vscode-docker
      github.copilot-chat
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "workbench.colorTheme" = "Autumn Material Light";
    };
  };
}
