{ style, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = style.fonts.default.name + ":size=14";
      };
      colors = with style.colors.material.schemes.light; rec {
        background = surface + "ee";
        text = on-surface + "ff";
        match = secondary-container + "ff";
        selection = primary-container + "ff";
        selection-text = text;
        selection-match = match;
      };
      border = {
        width = 0;
      };
    };
  };
}
