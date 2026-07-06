{...}: {
  imports = [./packages.nix];

  home.stateVersion = "26.05";

  # disable 'last login' text in terminal
  home.file.".hushlogin".text = "";

  home.file.".config/borders".source = ./config/borders;
  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/karabiner".source = ./config/karabiner;
  home.file.".config/rift".source = ./config/rift;
  home.file.".config/sketchybar" = {
    source = ./config/sketchybar;
    executable = true;
  };

  # export PATH='$HOME/.local/bin:$PATH'
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
