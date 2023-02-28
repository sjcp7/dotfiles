{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libappindicator-gtk3 libdbusmenu-gtk3 # tray support
  ];
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 30;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "pulseaudio" "backlight" "clock" "tray" ];
        
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

	"sway/window" = {
	  max-length = 50;
	};

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };


    };

      style = 
      ''
       * {
         border: none;
	 border-radius: 0;
	 font-family: Iosevka;
	 margin: 0 2px;
       }

       window#waybar {
         background-color: #3B4252; /* nord 1 */
	 color: #ECEFF4; /* nord 6 */
       }

       #workspaces button {
         color: #ECEFF4;
       }

       #workspaces button.focused {
         background-color: #81A1C1;
       }

      '';
  };

}
