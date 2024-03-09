{ config, lib, pkgs, ... }:

let mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    
    config = {
      modifier = mod;

      fonts = {
        names = [ "DejaVu Sans Mono" ];
        style = "Bold Semi-Condensed";
        size = 15.0;
      };

      floating.modifier = mod;

      terminal = "alacritty";

      window = {
        # NO BORDERS
        border = 0;

        commands = [
          {
            command = "fullscreen enable";
            criteria = {
              class = ".";
            };
          }
        ];
      };     

      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" =
          "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" =
          "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Focus /w arrow-keys
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Move /w arrow keys
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        # Split Vertically
        "${mod}+z" = "split v";

        # Split Horizontally 
        "${mod}+v" = "split h";

        # Change container layout
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # toggle tiling / floating
        "${mod}+Shift+space" = "floating toggle";

        # focus the parent container
        "${mod}+a" = "focus parent";

        # # switch to workspace
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";

        # move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";
      };

      bars = [
      { 
        position = "bottom";
        fonts = {
          names = [ "DejaVu Sans Mono" ];
          style = "Bold Semi-Condensed";
          size = 11.0;
        };
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}"; }];
    };
  };
}
