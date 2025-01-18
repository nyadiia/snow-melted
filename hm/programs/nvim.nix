{ pkgs, ... }:
let
  module = import ../../packages/nixvim.nix { inherit pkgs; };
in
{
  programs.nixvim = module // {
    enable = true;
    defaultEditor = true;
  };
}
