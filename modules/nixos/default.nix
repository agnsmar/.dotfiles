{
  pkgs,
  config,
  lib,
  inputs,
  outputs,
  myUtil,
  ...
}:
with lib; let
  cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
  features =
    myUtil.extendModules
    (name: {
      extraOptions = {
        myNixOS.${name}.enable = mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (mkIf cfg.${name}.enable config);
    })
    (myUtil.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    myUtil.extendModules
    (name: {
      extraOptions = {
        myNixOS.bundles.${name}.enable =
          mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (mkIf cfg.bundles.${name}.enable config);
    })
    (myUtil.filesIn ./bundles);

  # Taking all modules in ./dev and adding enables to them
  dev =
    myUtil.extendModules
    (name: {
      extraOptions = {
        myNixOS.dev.${name}.enable =
          mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (mkIf cfg.dev.${name}.enable config);
    })
    (myUtil.filesIn ./dev);
in {
  imports =
    [inputs.home-manager.nixosModules.home-manager]
    ++ features
    ++ bundles
    ++ dev;

  options = with types; {
    env = mkOption {
      type = attrsOf (oneOf [str path (listOf (either str path))]);
      apply = mapAttrs (n: v:
        if isList v
        then concatMapStringsSep ":" (x: toString x) v
        else (toString v));
      default = {};
      description = "TODO";
    };
  };
  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;

    env.PATH = ["$PATH"];

    # Adding new env variables require a system restart to take effect
    environment.extraInit =
      concatStringsSep "\n"
      (mapAttrsToList (n: v: ''export ${n}="${v}"'') config.env);
  };
}
