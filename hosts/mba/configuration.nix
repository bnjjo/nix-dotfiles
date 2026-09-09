{pkgs, ...}: {
  imports = [./aerospace.nix];

  networking.hostName = "nix-darwin";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  users.users.benjamin = {
    home = "/Users/benjamin";
    name = "benjamin";
  };

  fonts.packages = [
    pkgs.maple-mono.NormalNL-NF
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.symbols-only
    # pkgs.sketchybar-app-font
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      {
        name = "FelixKratz/formulae";
        trusted = true;
      }
      {
        name = "TheBoredTeam/boring-notch";
        trusted = true;
      }
      {
        name = "d12frosted/emacs-plus";
        trusted = true;
      }
    ];
    brews = [
      {
        name = "borders";
        start_service = true;
      }
    ];
    casks = [
      "boring-notch"
      "crossover"
      "emacs-plus-app"
      "ghostty"
      "karabiner-elements"
      "linearmouse"
      "nvidia-geforce-now"
      "raycast"
      "steam"
      "viber"
      "zen"
    ];
    masApps = {
      "Infuse" = 1136220934;
      "RetroArch" = 6499539433;
    };
  };

  launchd.user.agents.emacs.serviceConfig = {
    Label = "gnu.emacs.daemon";
    KeepAlive = true;
    ProgramArguments = [
      "/bin/zsh"
      "-ilc"
      "emacs --fg-daemon"
    ];
    RunAtLoad = true;
    ProcessType = "Interactive";
    StandardErrorPath = "/tmp/emacs.err.log";
    StandardOutPath = "/tmp/emacs.out.log";
  };

  services.sketchybar = {
    enable = false;
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
