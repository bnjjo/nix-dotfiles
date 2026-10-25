{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  mod = "Mod1";

  workspaceIndicies = [1 2 3 4 5 6 7 8 9];

  mappings = mod: ''
    # workspace switching
    ${lib.concatMapStrings
      (i: "bindsym ${mod}+${toString i} workspace number ${toString i}\n")
      workspaceIndicies}

    # bringing windows to workspaces
    ${lib.concatMapStrings
      (i: "bindsym ${mod}+Shift+${toString i} move container to workspace number ${toString i}; workspace number ${toString i}\n")
      workspaceIndicies}

    bindsym ${mod}+t exec ${pkgs.alacritty}/bin/alacritty msg create-window
    bindsym ${mod}+b exec ${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zen -P default
    bindsym ${mod}+s exec ${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/zen -P music

    bindsym Mod4+space exec ${pkgs.rofi}/bin/rofi -show drun
    bindsym Mod4+q kill
    bindsym ${mod}+v floating toggle

    bindsym ${mod}+h focus left
    bindsym ${mod}+j focus down
    bindsym ${mod}+k focus up
    bindsym ${mod}+l focus right

    bindsym ${mod}+Tab focus right
    bindsym ${mod}+Shift+Tab focus left

    bindsym ${mod}+Shift+h move left
    bindsym ${mod}+Shift+j move down
    bindsym ${mod}+Shift+k move up
    bindsym ${mod}+Shift+l move right

    # media
    bindsym XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
    bindsym XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindsym XF86AudioMute exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindsym XF86AudioMicMute exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindsym XF86AudioNext exec --no-startup-id playerctl next
    bindsym XF86AudioPrev exec --no-startup-id playerctl previous
    bindsym XF86AudioPlay exec --no-startup-id playerctl play-pause
    bindsym XF86AudioPause exec --no-startup-id playerctl play-pause

    # exit
    bindsym ${mod}+Shift+e exec i3-msg exit
  '';
in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;
      fonts = {
        names = ["JetBrains Mono Nerd Font Mono"];
        size = 12.0;
      };
      # no structured keybindings — everything lives in extraConfig now
      keybindings = lib.mkForce {};
      startup = [
        {
          command = "i3-msg workspace number 1";
          always = false;
          notification = false;
        }
        {
          command = "alacritty --daemon";
          notification = false;
        }
      ];
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status -c ${config.xdg.configHome}/i3status/config";
          fonts = {
            names = ["JetBrains Mono Nerd Font Mono"];
            size = 12.0;
          };
        }
      ];
    };
    extraConfig = mappings mod;
  };

  programs.i3status = {
    enable = true;
    general = {
      colors = true;
      interval = 1;
    };
    modules = {
      "ipv6".enable = false;
      "battery all".enable = false;
      "disk /".enable = false;
      "load".enable = false;
      "cpu_usage" = {
        enable = true;
        position = 1;
        settings = {
          format = "CPU: %usage";
        };
      };
      "memory" = {
        enable = true;
        position = 2;
        settings = {
          format = "RAM: %used / %total";
          threshold_degraded = "10%";
        };
      };
      "wireless _first_" = {
        enable = true;
        position = 3;
        settings = {
          format_up = "W: (%quality at %essid) %ip";
          format_down = "W: down";
        };
      };
      "ethernet _first_" = {
        enable = true;
        position = 4;
        settings = {
          format_up = "E: %ip (%speed)";
          format_down = "E: down";
        };
      };
      "volume master" = {
        enable = true;
        position = 5;
        settings = {
          format = "VOL: %volume";
          format_muted = "VOL: muted (%volume)";
        };
      };
      "tztime local" = {
        enable = true;
        position = 6;
        settings = {
          format = "%d-%m-%Y %H:%M:%S";
        };
      };
    };
  };

  services.redshift = {
    enable = true;
    temperature = {
      day = 6500;
      night = 3500;
    };
    latitude = 43.85;
    longitude = 18.36;
  };
}
