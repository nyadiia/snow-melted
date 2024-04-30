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
      rust-lang.rust-analyzer
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "everforest";
        publisher = "sainnhe";
        version = "0.3.0";
        sha256 = "nZirzVvM160ZTpBLTimL2X35sIGy5j2LQOok7a2Yc7U=";
      }
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      #"workbench.colorTheme" = "Everforest Dark";
    };
  };
}
