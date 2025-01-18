# styling info
# colors are in hex format with no `#`
#
# note that this isn't actually a module... so there's no real need for me to be calling this default.nix
# but i find it fun.
{ pkgs, inputs, ... }:
let
  colors = {
    material = import ./material-palette.nix;
    terminal = import ./terminal.nix;
  };
  fonts = import ./fonts.nix { inherit pkgs inputs; };
in
{
  inherit colors fonts;
  interpolate-theme = import ./interpolate.nix {
    inherit pkgs;
    style = { inherit colors fonts; };
  };
}
