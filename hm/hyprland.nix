{ pkgs, inputs, style, ... }:
{
  imports = [
    ./programs/ironbar.nix
    ./programs/alacritty.nix
    ./programs/fuzzel.nix
    ./programs/hyprpaper.nix
    ./gtk.nix
    ./swaync
    ./programs/hyprlock.nix
  ];

  services = {
    gammastep = {
      enable = true;
      tray = true;
      latitude = 44.97;
      longitude = -93.26;
    };
    network-manager-applet.enable = true;
    cliphist.enable = true;
  };

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    wl-clipboard
    libnotify
    kdePackages.polkit-kde-agent-1
  ];

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 32;
    x11.enable = true;
    gtk.enable = true;
  };
  qt.style.name = "adwaita";

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      # debug.disable_logs = false;
      exec-once = [
        "wl-paste --type text --watch cliphist store" #Stores only text data
        "wl-paste --type image --watch cliphist store" #Stores only image data
        "ironbar &"
      ];
      monitor = [
        "eDP-1,preferred,auto,1.175"
        #"eDP-1,addreserved,40,0,0,0"
        ",preferred,auto,auto"
        "desc:LG Electronics LG TV SSCR2 0x01010101,preferred,auto,2"
      ];
      misc.vfr = true;

      input = {
        kb_layout = "us";
        kb_options = "compose:caps";
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      general = {
        layout = "dwindle";
        border_size = 0;
      };

      gestures = {
        workspace_swipe = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      animations = {
        bezier = [
          "emphasized_decelerate, 0.05, 0.7, 0.1, 1"
          "emphasized_accelerate, 0.3, 0, 0.8, 0.15"
          "emphasized, 0.2, 0, 0, 1"
        ];
        animation = [
          "windows, 1, 5, emphasized, slide"
          "windowsIn, 1, 5, emphasized_decelerate, popin 40%"
          "windowsOut, 1, 3, emphasized_accelerate, slide"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 5, emphasized_decelerate, slide"
        ];
      };

      decoration = {
        rounding = 10;
        drop_shadow = true;
        dim_inactive = true;
        dim_strength = 0.05;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(34343477)";

        blur = {
          enabled = false;
          size = 2;
        };
      };

      layerrule = [
        #"dimaround, launcher"
      ];

      windowrulev2 = [
        "nodim,fullscreen:1"
      ];

      "$mod" = "SUPER";
      "$term" = "alacritty";
      "$runner" = "fuzzel";
      "$cliphist" = "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy && wl-paste";
      "$colorpicker" = "hyprpicker -a";

      bind = [
        "$mod, Return, exec, $term" # win + enter: open terminal
        "$mod SHIFT, Q, killactive" # win + shift + q: close focused window
        "$mod, D, exec, $runner" # win + d: open application launcher
        "$mod, V, exec, $cliphist" # win + v: open clipboard history
        ", Print, exec, grimblast copy area" # printsc: copy area
        "$mod, Print, exec, grimblast copy screen" # win + printsc: copy screen
        "$mod, F, fullscreen" # win + f: toggle fullscreen
        "$mod SHIFT, C, exec, $colorpicker" # win + shift + c: open color picker
        "$mod, T, exec, swaync-client -t" # win + t: togglet notification center
        "$mod, L, exec, hyprlock" # win + l: lock screen
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

      bindel = [
        # audio
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        # brightness
        ",XF86MonBrightnessUp, exec, light -A 5"
        ",XF86MonBrightnessDown, exec, light -U 5"
      ];

      bindm = [ "$mod, mouse:272, movewindow" ];
    };

    extraConfig = ''
      bind = $mod, R, submap, resize

      submap = resize
      binde = , right, resizeactive, 20 0
      binde = , left, resizeactive, -20 0
      binde = , up, resizeactive, 0 -20
      binde = , down, resizeactive, 0 20
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
