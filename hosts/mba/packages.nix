{pkgs, ...}: {
  imports = [
    ./starship.nix
    ../../common/bat.nix
    ../../common/eza.nix
    ../../common/fd.nix
    ../../common/git.nix
    ../../common/langs.nix
    ../../common/ripgrep.nix
    ../../common/television.nix
    ../../common/tmux.nix
  ];

  home.packages = with pkgs; [
    btop
    chafa
    cloc
    fastfetch
    lazygit
    mpv
    neovim
    nix-search-tv
    tree-sitter
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
    '';
  };
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
      rift = "~/Code/source/rift/target/release/rift";
      update = "nix flake update --flake ~/nix-dotfiles && reb";
      fastfetch = "fastfetch --logo 'NixOS'";
    };
  };
}
