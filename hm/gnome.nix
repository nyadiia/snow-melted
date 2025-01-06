{ pkgs, ... }:

{
  imports = [
    ./gtk.nix
  ];
  home.packages = with pkgs; [
    gnome.gnome-tweaks

    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.fullscreen-avoider
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.user-themes
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "fullscreen-avoider@noobsai.github.com"
        "openweather-extension@jenslody.de"
      ];
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
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #   name = "terminal";
    #   command = "kgx";
    #   binding = "<Super>Return";
    # };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" "variable-refresh-rate" ];
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };
  };
}
