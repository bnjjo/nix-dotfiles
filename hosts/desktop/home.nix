{...}: {
  imports = [
    ./theming.nix
    ./packages.nix
    ./services.nix
  ];

  home.username = "benjamin";
  home.homeDirectory = "/home/benjamin";
  home.stateVersion = "26.05";

  # PATH
  home.sessionPath = [
    "$HOME/.local/share/flatpak/exports/bin"
  ];
}
