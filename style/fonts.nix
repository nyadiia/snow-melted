{ pkgs, inputs, ... }:
rec {
  default = {
    name = "SF Pro";
    package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro;
  };
  monospace = {
    name = "FiraCode Nerd Font";
    package = pkgs.nerd-fonts.fira-code;
  };
  font-packages = [
    default.package
    monospace.package
  ];
}
