{ pkgs, style, ... }:
let
  hexed = builtins.mapAttrs (name: color: "#" + color);
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = with style.colors.terminal.light; {
        primary = hexed ({
          background = background;
          foreground = foreground;
        });
        normal = hexed (with dim; {
          inherit
            red
            green
            yellow
            blue
            magenta
            cyan
            ;
          black = background;
          white = gray;
        });
        bright = hexed (with bright; {
          inherit
            red
            green
            yellow
            blue
            magenta
            cyan
            ;
          black = gray;
          white = foreground;
        });
      };
    };
  };
}
