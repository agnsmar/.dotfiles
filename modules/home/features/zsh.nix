{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "nix fmt ~/.dotfiles; git add ~/.dotfiles/*; sudo nixos-rebuild switch --flake ~/.dotfiles#laptop";
      upgrade = "nix fmt ~/.dotfiles; git add ~/.dotfiles/*; sudo nixos-rebuild switch --upgrade  --flake ~/.dotfiles#laptop";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    initExtra = ''bindkey -s ^f "tmux-sessionizer\n"''; # The greatest thing ever created
    oh-my-zsh = {
      enable = true;
      plugins = ["ssh-agent" "git" "sudo"];
      theme = "robbyrussell";
    };
  };
}
