{ pkgs, ... }:
{
  imports = [
    ./programs/waybar.nix
  ];

  services = {
    gammastep = {
      enable = true;
      tray = true;
      latitude = 44.97;
      longitude = -93.26;
    };
    network-manager-applet.enable = true;
  };

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 20;
    x11.enable = true;
    gtk.enable = true;
  };

  home.packages = with pkgs; [ swaynotificationcenter ];

  programs.alacritty.enable = true;

  programs.fuzzel.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "waybar &"
        "swaync &"
      ];
      monitor = [
        "eDP-1,preferred,auto,1.175"
        "eDP-1,addreserved,40,0,0,0"
        ",preferred,auto,auto"
      ];
      misc.vfr = true;

      "$mod" = "SUPER";
      "$term" = "alacritty";
      "$runner" = "fuzzel";

      input = {
        kb_layout = "us";
        kb_options = "compose:caps";
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      general = {
        layout = "dwindle";
      };

      bind = [
        "$mod, Return, exec, $term"
        "$mod SHIFT, Q, killactive"
        "$mod, D, exec, $runner"

      ] ++ (
        # workspaces
        # binds $mod + [ shift + ] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let c = (x + 1) / 10; in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10)
      );

      bindm = [ "$mod, mouse:272, movewindow" ];
    };
  };
}
