{ style, ... }:
{
  services.swaync = {
    enable = true;
    style = style.interpolate-theme ./style.css;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      layer-shell = "true";
      control-center-margin-top = 20;
      control-center-margin-right = 20;
      control-center-margin-bottom = 20;
    };
  };
}
