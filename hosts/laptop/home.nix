{ inputs, outputs, pkgs, lib, ... }: {
  imports = [
    outputs.homeManagerModules.default
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-terminal-dark;

  myHomeManager = {
    i3.enable = true;
    zsh.enable = true;
    ssh.enable = true;
    tmux.enable = true;
    nvim.enable = true;
    alacritty.enable = true;
    git.enable = true;
  };
  
  services.picom.enable = true;
  
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Dark";
    iconTheme.package = pkgs.arc-icon-theme;
    iconTheme.name = "Arc";
  };

  home = {
    username = "agnes";
    homeDirectory = lib.mkDefault "/home/agnes";
    pointerCursor = {
      x11.enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 128;
    };
    stateVersion = "23.11";
    packages = with pkgs; [
      (writeShellScriptBin "tmux-sessionizer"
        (lib.readFile ./../../modules/home/features/tmux/tmux-sessionizer))
      tmux-sessionizer
      fzf
      neofetch
      typescript
      rustup
      nodejs_21
    ];
  };
}
