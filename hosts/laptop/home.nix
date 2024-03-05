{ inputs, outputs, pkgs, lib, ... }: {
  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    zsh.enable = true;
    nvim.enable = true;
    alacritty.enable = true;
    git.enable = true;
  };

  home = {
    username = "agnes";
    homeDirectory = lib.mkDefault "/home/agnes";
    stateVersion = "23.11";
    packages = with pkgs; [ neofetch ];
  };
}
