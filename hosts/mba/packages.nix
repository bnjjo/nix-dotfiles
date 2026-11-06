{pkgs, ...}: {
  imports = [
    ./starship.nix
    ../../common/bat.nix
    ../../common/direnv.nix
    ../../common/fd.nix
    ../../common/git.nix
    ../../common/langs.nix
    ../../common/ripgrep.nix
    ../../common/television.nix
    ../../common/tmux.nix
    ../../common/yazi.nix
  ];

  home.packages = with pkgs; [
    btop
    chafa
    cloc
    fastfetch
    fontconfig
    lazygit
    mpv
    neovim
    nix-search-tv
    pulseaudio
    tree-sitter
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      l = "ls -a";
      ll = "ls -a";
    };
    initExtra = ''
      set -o vi
    '';
  };
  programs.nushell = {
    enable = true;
    environmentVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    shellAliases = {
      fastfetch = "^fastfetch --logo 'NixOS'";
      l = "ls -a";
      ll = "ls -a";
    };
    extraConfig = ''
      $env.config.edit_mode = "vi"

      def reb [] {
        sudo darwin-rebuild switch --flake $"($env.HOME)/nix-dotfiles#nix-darwin"
      }

      def nix-update [] {
        sudo whoami
        nix flake update --flake $"($env.HOME)/nix-dotfiles"
        reb
      }
    '';
    loadSessionVariables = true;
  };
  # programs.zsh = {
  #   enable = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;
  #   initContent = ''
  #     bindkey -v
  #     export EDITOR=nvim
  #     export VISUAL=nvim
  #   '';
  #   shellAliases = {
  #     reb = "sudo darwin-rebuild switch --flake ~/nix-dotfiles#nix-darwin";
  #     update = "sudo whoami; nix flake update --flake ~/nix-dotfiles && reb";
  #     fastfetch = "fastfetch --logo 'NixOS'";
  #   };
  # };
}
