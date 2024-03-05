{ pkgs, config, ... }: {
  programs.git = {
    enable = true;
    userName = "Agnes Martinsson";
    userEmail = "agnesdlmartinsson@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
      init.defaultBranch = "main";
      safe.directory = "~/.dotfiles";
    };
  };
}
