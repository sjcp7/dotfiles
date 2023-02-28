{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Nord";
    font = {
      name = "iosevka-medium";
      package = pkgs.iosevka-bin;
      size = 11;
    };
  };
}
