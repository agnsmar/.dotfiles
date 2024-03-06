{ inputs, outputs, pkgs, lib, ... }: {
  imports = [
    outputs.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-terminal-dark;

  myHomeManager = {
    # languages.enable = true;
    zsh.enable = true;
    nvim.enable = true;
    alacritty.enable = true;
    git.enable = true;
  };

  home = {
    username = "agnes";
    homeDirectory = lib.mkDefault "/home/agnes";
    stateVersion = "23.11";
    packages = with pkgs; [ neofetch rustc cargo typescript nodejs_21 ];
  };
}
