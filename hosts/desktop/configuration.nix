{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.services."systemd-machine-id-commit".unitConfig.ConditionFirstBoot = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  time.timeZone = "Europe/Sarajevo";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.benjamin = {
    isNormalUser = true;
    hashedPasswordFile = "/persistent/passwd";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.dconf.enable = true; # for firefox to accept theming
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    inputs.dwl.packages.x86_64-linux.default
    inputs.slstatus.packages.x86_64-linux.default
  ];

  services.flatpak.enable = true;
  services.getty.autologinUser = "benjamin";
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # neeeded for flatpak
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      mesa
    ];
  };

  zramSwap.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
