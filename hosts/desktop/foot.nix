{config, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        include = "${config.xdg.configHome}/foot/themes/noctalia";
        pad = "10x0";
        font = "JetBrains Mono Nerd Font:size=14.5";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      cursor = {
        blink = "yes";
      };
      text-bindings = {
        "\\x1b1" = "Mod4+1";
        "\\x1b2" = "Mod4+2";
        "\\x1b3" = "Mod4+3";
        "\\x1b4" = "Mod4+4";
        "\\x1b5" = "Mod4+5";
        "\\x1b6" = "Mod4+6";
        "\\x1b7" = "Mod4+7";
        "\\x1b8" = "Mod4+8";
        "\\x1b9" = "Mod4+9";
        "\\x1b0" = "Mod4+0";
      };
    };
  };
}
