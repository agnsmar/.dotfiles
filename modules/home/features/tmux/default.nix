{ pkgs, config, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
