{ config, pkgs, ... }:
{
  services.gammastep = {
    enable = true;
    dawnTime = "6:00-7:00";
    duskTime = "17:00-18:00";
    latitude = -8.8;
    longitude = 13.2;
    tray = true;
  };
}
