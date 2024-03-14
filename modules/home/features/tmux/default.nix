{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    extraConfig = with config.colorScheme.palette; ''
      # Theming
      set -g status-style 'bg=#${base00} fg=#${base06}'

      # Draw the rest of the owl
      ${builtins.readFile ./tmux.conf}
    '';
  };
}
