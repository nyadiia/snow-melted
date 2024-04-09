{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      exclusive = false;
      height = 30;
      margin = "10 10 0 10";
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [ "hyprland/submap" "pulseaudio" "battery" "clock" "tray" ];
      tray = { spacing = 10; };
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "default" = "";
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "active" = "󱓻";
          "urgent" = "󱓻";
        };
        on-click = "activate";
      };
    }];
    style = ./waybar.css;
  };
}
