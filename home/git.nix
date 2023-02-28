{ configs, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Samuel Pedro";
    userEmail = "redsamuel.cruz7@gmail.com";
    extraConfig = {
      color.ui = "auto";
      init.defaultBranch = "main";
    };
  };
}
