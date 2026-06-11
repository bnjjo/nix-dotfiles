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
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
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
      "linearmouse"
      "nvidia-geforce-now"
      "raycast"
      "zen"
    ];
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
    };
  };

  system.stateVersion = 6;
}
