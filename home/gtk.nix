{ config, pkgs, ...}:
{
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
    };

    iconTheme = {
      name = "Adwaita";
    };

    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
    };
  };
}
