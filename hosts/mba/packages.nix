{pkgs, ...}: {
  imports = [
    ../../common.nix
  ];

  home.packages = with pkgs; [
    btop
    cloc
    fastfetch
    lazygit
    mpv
    neovim
    nix-search-tv
    tree-sitter
  ];

  programs.bash.enable = true;
  programs.git = {
    enable = true;
    settings.user.name = "bnjjo";
    settings.user.email = "131111426+bnjjo@users.noreply.github.com";
  };
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      bindkey -v
    '';
    shellAliases = {
      l = "eza -lha";
      ll = "eza -lha";
      ls = "eza";
      reb = "sudo darwin-rebuild switch --flake ~/nix-dotfiles#nix-darwin";
      rift = "~/Code/src/rift/target/release/rift";
      update = "nix flake update --flake ~/nix-dotfiles && reb";
      fastfetch = "fastfetch --logo 'NixOS'";
    };
  };
}
