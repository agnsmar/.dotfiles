{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [gcc rustup];
    environment.shellAliases = {
      rs = "rustc";
      rsp = "rustup";
      ca = "cargo";
    };

    env.RUSTUP_HOME = "$HOME/.rustup";
    env.CARGO_HOME = "$HOME/.cargo";
    env.PATH = ["$CARGO_HOME/bin"];
  };
}
