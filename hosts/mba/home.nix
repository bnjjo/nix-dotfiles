# darwin.nix
{...}: {
  imports = [./packages.nix];

  home.stateVersion = "26.05";

  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/karabiner".source = ./config/karabiner;
  home.file.".config/borders".source = ./config/borders;
  home.file.".config/rift".source = ./config/rift;

  # disable 'last login' text in terminal
  home.file.".hushlogin".text = "";

  # export PATH='$HOME/.local/bin:$PATH'
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
