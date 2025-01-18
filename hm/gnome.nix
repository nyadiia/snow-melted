{ pkgs, ... }:

{
  imports = [
    ./gtk.nix
  ];
  home.packages =
    (with pkgs; [
      gnome-tweaks
      adw-gtk3
    ])
    ++ (with pkgs.gnomeExtensions; [
      vitals
      user-themes
      dash-to-dock
      fullscreen-avoider
      blur-my-shell
      caffeine
      user-themes
      app-menu-is-back
      pop-shell
      appindicator
      tiling-shell
    ]);

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "fullscreen-avoider@noobsai.github.com"
        "appmenu-is-back@fthx"
        "pop-shell@system76.com"
        "Vitals@CoreCoding.com"
      ];
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = "['terminate:ctrl_alt_bksp', 'compose:caps']";
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = "disabled";
      toggle-message-tray = "disabled";
      close = [ "<Super>q" ];
      maximize = "disabled";
      minimize = [ "<Super>comma" ];
      move-to-monitor-down = "disabled";
      move-to-monitor-left = "disabled";
      move-to-monitor-right = "disabled";
      move-to-monitor-up = "disabled";
      move-to-workspace-down = "disabled";
      move-to-workspace-up = "disabled";
      toggle-maximized = [ "<Super>m" ];
      unmaximize = "disabled";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "terminal";
      command = "ghostty";
      binding = "<Super>Return";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/mutter" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        "variable-refresh-rate"
      ];
    };
    "org/gnome/desktop/interface" = {
      accent-color = "pink";
      font-name = "SF Pro 11 @opsz=17";
      show-battery-percentage = true;
    };
  };
}
