{pkgs, ...}:
{
  stylix = {
    image = ./fake_image.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    fonts = rec {
      serif = sansSerif;
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "Fira Code Nerd Font";
      };
      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twemoji";
      };
    };
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 20;
    };
  };
}