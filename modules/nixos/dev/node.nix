{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [nodejs_21 bun typescript];
  };
}
