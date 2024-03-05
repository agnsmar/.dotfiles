{ pkgs, config, lib, inputs, outputs, myUtil, ... }:
let
  cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
  features = myUtil.extendModules (name: {
    extraOptions = {
      myNixOS.${name}.enable =
        lib.mkEnableOption "enable my ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (myUtil.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles = myUtil.extendModules (name: {
    extraOptions = {
      myNixOS.bundles.${name}.enable =
        lib.mkEnableOption "enable ${name} module bundle";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (myUtil.filesIn ./bundles);
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ] ++ features
    ++ bundles;

  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}
