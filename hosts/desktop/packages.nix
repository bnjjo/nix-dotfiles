{pkgs, ...}: {
  imports = [
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
    brightnessctl
    cliphist
    fastfetch
    firefox
    gcc
    gnumake
    neovim
    nix-search-tv
    playerctl
    rofimoji
    tree-sitter
    wbg # background setting tool
    wlopm # dpms manager
    wlsunset
    wl-clipboard
    wmenu
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      l = "ls -lha";
      ll = "ls -lha";
      reb = "sudo nixos-rebuild switch --flake ~/nix-dotfiles";
      update = "nix flake update --flake ~/nix-dotfiles && reb";
    };
    initExtra = ''
      set -o vi
    '';
  };
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "JetBrains Mono Nerd Font:size=14.5";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors-dark = {
        alpha = "0.93";
        # tokyonight night
        background = "1a1b26";
        foreground = "c0caf5";

        regular0 = "15161E";
        regular1 = "f7768e";
        regular2 = "9ece6a";
        regular3 = "e0af68";
        regular4 = "7aa2f7";
        regular5 = "bb9af7";
        regular6 = "7dcfff";
        regular7 = "a9b1d6";

        bright0 = "414868";
        bright1 = "f7768e";
        bright2 = "9ece6a";
        bright3 = "e0af68";
        bright4 = "7aa2f7";
        bright5 = "bb9af7";
        bright6 = "7dcfff";
        bright7 = "c0caf5";
      };
      text-bindings = {
        "\\x1b1" = "Mod4+1";
        "\\x1b2" = "Mod4+2";
        "\\x1b3" = "Mod4+3";
        "\\x1b4" = "Mod4+4";
        "\\x1b5" = "Mod4+5";
        "\\x1b6" = "Mod4+6";
        "\\x1b7" = "Mod4+7";
        "\\x1b8" = "Mod4+8";
        "\\x1b9" = "Mod4+9";
        "\\x1b0" = "Mod4+0";
      };
    };
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
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
      reb = "sudo nixos-rebuild switch --flake ~/nix-dotfiles#nixos";
      update = "nix flake update --flake ~/nix-dotfiles && reb";
      start-dwl = "~/nix-dotfiles/hosts/desktop/suckless/slstatus/result/bin/slstatus -s | ~/nix-dotfiles/hosts/desktop/suckless/dwl/result/bin/dwl";
    };
  };
}
