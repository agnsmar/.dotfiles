{
  pkgs,
  config,
  ...
}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        Hostname github.com
        User agnsmar
        IdentityFile ~/.ssh/github
    '';
  };
}
