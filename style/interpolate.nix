{ pkgs, style, ... }:
let
  themeFile = builtins.toFile "theme.json" (builtins.toJSON {
    inherit (style) colors;
    fonts = {
      default = { name = style.fonts.default.name; };
      monospace = { name = style.fonts.monospace.name; };
    };
  });
in
path:
pkgs.runCommand "interpolate-theme" { } ''
  ${pkgs.mustache-go}/bin/mustache ${themeFile} ${path} > $out
''
