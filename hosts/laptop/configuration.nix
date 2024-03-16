{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myUtil,
  ...
}: let
  MHz = x: x * 1000;
  inherit (lib) mkDefault;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  environment.pathsToLink = ["/libexec"];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    dpi = 140;
    desktopManager = {xterm.enable = false;};

    displayManager = {defaultSession = "none+i3";};

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [dmenu i3status-rust material-icons i3lock];
    };
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        scaling_min_freq = mkDefault (MHz 1800);
        scaling_max_freq = mkDefault (MHz 3600);
        turbo = "never";
      };
      charger = {
        governor = "performance";
        scaling_min_freq = mkDefault (MHz 2000);
        scaling_max_freq = mkDefault (MHz 4800);
        turbo = "auto";
      };
    };
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "se";
      variant = "nodeadkeys";
    };
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  myNixOS = {
    bundles.users.enable = true;
    dev.rust.enable = true;
    dev.node.enable = true;

    home-users = {
      "agnes" = {
        userConfig = ./home.nix;
        userSettings = {
          extraGroups = ["networkmanager" "wheel"];
          initialPassword = "123456789";
        };
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "agnes";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    google-chrome
    discord
    spotify
    _1password-gui
    lxappearance
  ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
