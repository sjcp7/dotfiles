{ lib, config, pkgs, ... }:

let
  mod = "Mod4";
in {
  imports = [ 
    ./waybar.nix 
    ./kitty.nix
    ./gammastep.nix
  ];
  home.packages = with pkgs; [
    swaylock swayidle wofi playerctl
    sway-contrib.grimshot
    wdisplays kanshi mako clipman 
    brightnessctl blueberry 
    pavucontrol pulseaudio # sound control (pulseaudio = pactl)
    networkmanagerapplet
  ];
  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = mod;

      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };

      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessDown" = "exec brightnessctl -q s 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl -q s 5%+";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
      };

      bars = [
        { command = "${pkgs.waybar}/bin/waybar"; }
      ]; 

      menu = "${pkgs.wofi}/bin/wofi --show drun";

      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };

      startup = [
        { command = "nm-applet"; }
        { command = "blueberry-tray"; }
      ];

      terminal = "${pkgs.kitty}/bin/kitty";

      window.hideEdgeBorders = "smart";
    };

    wrapperFeatures.gtk = true;

   };

}
