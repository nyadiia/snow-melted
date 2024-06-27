{ style, config, ... }:
{
  programs.hyprlock = with style.colors.material.schemes.light; {
    enable = true;
    settings = {
      background = [{
        path = toString ../../assets/springtime_fw_bg.png;
      }];
      label = [{
        text = "$TIME";
        font_family = style.fonts.default.name;
        font_size = 64;
        color = "#" + primary;
      }];
      input-field = [{
        font_color = "#" + on-surface;
        outer_color = "#" + surface;
        inner_color = "#" + surface;
        check_color = "#" + primary;
        fail_color = "#" + error;
        outline_thickness = 0;

      }];
    };
  };
}
