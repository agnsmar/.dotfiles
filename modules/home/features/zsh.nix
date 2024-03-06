{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "pushd ~/.dotfiles; git add .; sudo nixos-rebuild switch --flake ~/.dotfiles#laptop; popd";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
  };
}
