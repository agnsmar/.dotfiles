{
  lib,
  config,
  inputs,
  outputs,
  myUtil,
  pkgs,
  ...
}: let
  cfg = config.myNixOS;
in {
  options.myNixOS.home-users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        userConfig = lib.mkOption {
          default = ./.;
          example = "DP-1";
        };
        userSettings = lib.mkOption {
          default = {};
          example = "{}";
        };
      };
    });
    default = {};
  };

  config = {
    programs.zsh.enable = true;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
        inherit myUtil;
        outputs = inputs.self.outputs;
      };

      users =
        builtins.mapAttrs
        (name: user: {...}: {
          imports = [(import user.userConfig) outputs.homeManagerModules.default];
        })
        (config.myNixOS.home-users);
    };

    users.users =
      builtins.mapAttrs
      (name: user:
        {
          isNormalUser = true;
          initialPassword = "123456789";
          description = "";
          shell = pkgs.zsh;
          extraGroups = ["networkmanager" "wheel"];
        }
        // user.userSettings)
      (config.myNixOS.home-users);
  };
}
