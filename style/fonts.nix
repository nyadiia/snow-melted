{ pkgs, ... }:
rec {
  default = {
    name = "Roboto";
    package = pkgs.roboto;
  };
  monospace = {
    name = "FiraCode Nerd Font";
    package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
  };
  font-packages = [ default.package monospace.package ];
}
