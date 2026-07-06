{pkgs, ...}: {
  networking.hostName = "nix-darwin";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  users.users.benjamin = {
    home = "/Users/benjamin";
    name = "benjamin";
  };

  fonts.packages = [
    pkgs.maple-mono.NormalNL-NF
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.sketchybar-app-font
  ];

  imports = [./aerospace.nix];

  homebrew = {
    enable = true;
    # https://github.com/nix-darwin/nix-darwin/issues/1787
    onActivation.cleanup = "zap"; # reenable once fixed
    # onActivation.cleanup = "none";
    taps = [
      "FelixKratz/formulae"
      "TheBoredTeam/boring-notch"
    ];
    brews = [
      {
        name = "borders";
        start_service = true;
      }
    ];
    casks = [
      "boring-notch"
      "ghostty"
      "karabiner-elements"
      "iloader"
      "linearmouse"
      "nvidia-geforce-now"
      "raycast"
      "viber"
      "zen"
    ];
    masApps = {
      "Infuse" = 1136220934;
    };
  };

  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
  };

  system.primaryUser = "benjamin";
  system.defaults = {
    dock = {
      orientation = "right";
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.0;
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      _HIHideMenuBar = true;
    };
  };

  system.stateVersion = 6;
}
