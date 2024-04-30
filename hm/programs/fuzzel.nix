{ lib, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # stylix gives me a size 10 font, which is waaaay too small
       font = lib.mkForce "Roboto:size=14";
      };
      # colors = rec {
      #   background = "272e33ff";
      #   text = "d3c6aaff";
      #   match = "a7c080ff";
      #   selection = "2e383cff";
      #   selection-text = text;
      #   selection-match = match;
      # };
      border = {
        width = 0;
      };
    };
  };
}