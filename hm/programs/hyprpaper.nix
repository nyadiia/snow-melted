let
  wallpaper = "${../../assets/springtime_fw_bg.png}";
in
{
  services.hyprpaper = {
    enable = true;
    preloads = [ wallpaper ];
    wallpapers = [ ",${wallpaper}" ];
  };
}
