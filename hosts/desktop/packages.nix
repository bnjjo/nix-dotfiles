{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./foot.nix
    ./starship.nix
    ../../common/bat.nix
    ../../common/eza.nix
    ../../common/fd.nix
    ../../common/git.nix
    ../../common/langs.nix
    ../../common/ripgrep.nix
    ../../common/television.nix
    ../../common/tmux.nix
    ../../common/yazi.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    chafa
    fastfetch
    gcc
    jellyfin-mpv-shim
    mpv
    neovim
    nix-search-tv
    tree-sitter
    xdg-utils # for neovim gx i.e. xdg-open and so on
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      l = "eza -lha --icons --git";
      ll = "l";
      reb = "sudo nixos-rebuild switch --flake ~/nix-dotfiles";
      update = "sudo whoami; nix flake update --flake ~/nix-dotfiles && reb";
    };
    initExtra = ''
      set -o vi
       export EDITOR=nvim
      export VISUAL=nvim
    '';
  };
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      l = "eza -lha --icons --git";
      ll = "l";
      ls = "eza";
      reb = "sudo nixos-rebuild switch --flake ~/nix-dotfiles#nixos";
      update = "sudo whoami; nix flake update --flake ~/nix-dotfiles && reb";
    };
    initContent = ''
      bindkey -v
      export EDITOR=nvim
      export VISUAL=nvim
    '';
  };
}
