{ pkgs, ... }:
{


  programs.ironbar = {
    enable = true;
    style = builtins.readFile ./ironbar.css;
    config = {
      anchor_to_edges = true;
      position = "top";
      height = 14;
      #icon_theme = "oomox-gruvbox-dark";
      start = [
        { type = "workspaces"; }
        {
          type = "focused";
          show_icon = false;
          show_title = true;
          icon_size = 32;
          truncate = "end";
        }
      ];
      center = [
        {
          type = "clock";
          format = "%H:%M";
          format_popup = "%m/%d/%Y %H:%M:%S";
        }
      ];
      end = [
        { type = "volume"; }
        {
          type = "sys_info";
          format = [
            " {cpu_percent}% | {temp_c:coretemp-Package-id-0}°C"
          ];
          interval = {
            cpu = 1;
          };
        }
        {
          type = "tray";
          icon_size = 32;
        }
        {
          type = "upower";
          format = "{percentage}%";
        }
      ];
    };
  };
}
