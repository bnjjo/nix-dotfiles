{...}: {
  imports = [
    ./packages.nix
  ];

  home.username = "benjamin";
  home.homeDirectory = "/home/benjamin";

  home.stateVersion = "26.05";
}
