{ pkgs, system, inputs, config, lib, myUtil, ... }:
with lib;
let
  cfg = config.myHomeManager;

  # Taking all modules in ./features and adding enables to them
  features = myUtil.extendModules (name: {
    extraOptions = {
      myHomeManager.${name}.enable =
        mkEnableOption "enable my ${name} configuration";
    };

    configExtension = config: (mkIf cfg.${name}.enable config);
  }) (myUtil.filesIn ./features);
in { imports = [ ] ++ features; }
