# styling info
# colors are in hex format with no `#`
#
# note that this isn't actually a module... so there's no real need for me to be calling this default.nix
# but i find it fun.
{
  colors = {
    material = import ./material-palette.nix;
    terminal = import ./terminal.nix;
  };
  fonts = import ./fonts.nix;
}