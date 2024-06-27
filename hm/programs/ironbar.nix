{ style, ... }:
{


  programs.ironbar = {
    enable = true;
    style = builtins.readFile (style.interpolate-theme ./ironbar.css);
    config = {
      anchor_to_edges = true;
      position = "top";
      height = 14;
      margin = {
        top = 20;
        left = 20;
        right = 20;
      };
      #icon_theme = "oomox-gruvbox-dark";
      start = [
        {
          type = "workspaces";
          # name_map = 
          #   let 
          #     a = n: { name = toString n; value = "•"; };
          #     list = builtins.genList a 10;
          #   in
          #     builtins.listToAttrs list;
        }
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
          format = "%I:%M %p";
          format_popup = "%A, %B %e";
        }
      ];
      end = [
        { type = "volume"; }
        {
          type = "sys_info";
          format = [
            "  {cpu_percent}% | {temp_c:coretemp-Package-id-0}°C"
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
        {
          type = "notifications";
        }
      ];
    };
  };
}
