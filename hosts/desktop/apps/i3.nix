{
  lib,
  pkgs,
  inputs,
  ...
}: let
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = {
        names = ["JetBrains Mono Nerd Font Mono"];
        size = 12.0;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+t" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${mod}+b" = "exec ${
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/zen";
        "${mod}+s" = "exec ${
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/zen -P music";

        "Mod4+space" = "exec ${pkgs.rofi}/bin/rofi -show drun";

        "Mod4+q" = "kill";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+shift+h" = "move left";
        "${mod}+shift+j" = "move down";
        "${mod}+shift+k" = "move up";
        "${mod}+shift+l" = "move right";

        # media stuff
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

        "XF86AudioNext" = "exec --no-startup-id playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
        "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
        "XF86AudioPause" = "exec --no-startup-id playerctl play-pause";
      };

      startup = [
        {
          command = "i3-msg workspace number 1";
          always = false;
          notification = false;
        }
      ];

      bars = [
        {
          position = "bottom";
          fonts = {
            names = ["JetBrains Mono Nerd Font Mono"];
            size = 12.0;
          };
        }
      ];
    };
  };
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500;
      night = 3500;
    };
    # set your location so it knows when sunset/sunrise is
    latitude = 43.85; # replace with yours
    longitude = 18.36;
  };
}
