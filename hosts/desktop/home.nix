{...}: {
  imports = [
    ./theming.nix
    ./packages.nix
  ];

  home.username = "benjamin";
  home.homeDirectory = "/home/benjamin";
  home.stateVersion = "26.05";

  # PATH
  home.sessionPath = [
    "$HOME/.local/share/flatpak/exports/bin"
  ];

  home.file.".config/mako/config".source = ./config/mako/config;
  home.file.".config/wob/wob.ini".source = ./config/wob/wob.ini;
}
