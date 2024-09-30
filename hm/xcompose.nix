{ pkgs, inputs, style, ... }:
{
  home.file.".XCompose" = {
    source = ./XCompose;
  };
}