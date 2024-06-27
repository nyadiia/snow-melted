{ pkgs, style, ... }:
let
  light-theme = style.interpolate-theme ./theme-light.mustache;
  dark-theme = style.interpolate-theme ./theme-dark.mustache;
  theme-extension = pkgs.runCommandLocal "autumn-material"
    {
      vscodeExtUniqueId = "autumn.material";
      vscodeExtPublisher = "auctumnus";
      version = "0.0.1";
    } ''
    mkdir -p "$out/share/vscode/extensions/$vscodeExtUniqueId/themes"
    cp ${./package.json} "$out/share/vscode/extensions/$vscodeExtUniqueId/package.json"
    ln -s ${light-theme} "$out/share/vscode/extensions/$vscodeExtUniqueId/themes/material-light.json"
    ln -s ${dark-theme} "$out/share/vscode/extensions/$vscodeExtUniqueId/themes/material-dark.json"
  '';
in
{
  programs.vscode = {
    extensions = [ theme-extension ];
    userSettings = {
      "workbench.colorTheme" = "Autumn Material Light";
      "terminal.integrated.fontFamily" = style.fonts.monospace.name;
      "editor.fontFamily" = style.fonts.monospace.name;
    };
  };
}
