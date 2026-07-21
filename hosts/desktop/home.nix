{...}: {
  imports = [
    # ./theming.nix
    ./packages.nix
  ];

  home.username = "benjamin";
  home.homeDirectory = "/home/benjamin";

  home.file.".config/hypr".source = ./config/hypr;

  home.stateVersion = "26.05";
}
