{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # pin gpu min mhz to 950
  systemd.services.set-gpu-min-freq = {
    description = "Set Intel GPU min frequency";
    wantedBy = ["multi-user.target"];
    after = ["sysinit.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'echo 950 > /sys/class/drm/card1/gt_min_freq_mhz'";
    };
  };
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
  ];

  services.getty.autologinUser = "benjamin";
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  # for noctalia
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # hyprland
  programs.hyprland.enable = true;

  # needed for file dialogs, screen sharing
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     # pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #   # config.hyprland.default = ["hyprland" "gtk"];
  # };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      mesa
    ];
  };

  # enable hardware virtualization
  virtualisation.libvirtd.enable = true;

  zramSwap.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
