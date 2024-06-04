{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [jdk];
  };
}
