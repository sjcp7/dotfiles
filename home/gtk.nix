{ config, pkgs, ...}:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic-bluish-accent";
    };

    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons";
    };

    cursorTheme = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
    };
  };
}
