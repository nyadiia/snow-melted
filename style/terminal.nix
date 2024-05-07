let
  material = import ./material-palette.nix;
in
{
  light = with material.schemes.light; let palettes = material.palettes; in {
    foreground = on-surface;
    background = surface;

    bright = {
      red = error;
      green = primary;
      yellow = "DC7500";
      blue = secondary;
      magenta = "76428A";
      cyan = tertiary;
      gray = outline;
    };
    dim = {
      red = on-error-container;
      green = palettes.primary."50";
      yellow = "B05D00";
      blue = palettes.secondary."50";
      magenta = "BC58BF";
      cyan = palettes.tertiary."50";
      gray = palettes.neutral."40";
    };
  };
}