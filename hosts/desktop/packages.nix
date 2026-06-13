{
  inputs,
  pkgs,
  ...
}: {
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
    chafa
    cliphist
    fastfetch
    gcc
    gnumake
    grim
    mako
    neovim
    nix-search-tv
    playerctl
    rofimoji
    slurp
    swayidle
    tree-sitter
    wbg # background setting tool
    wlopm # dpms manager
    wlsunset
    wl-clipboard
    wob
    wmenu
    xdg-utils # for neovim gx i.e. xdg-open and so on
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
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
        pad = "10x0";
        font = "JetBrains Mono Nerd Font:size=14.5";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      cursor = {
        blink = "yes";
      };
      colors-dark = {
        alpha = "0.96";

        # gruvbox dark
        background = "282828";
        foreground = "ebdbb2";
        regular0 = "282828";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "a89984";
        bright0 = "928374";
        bright1 = "fb4934";
        bright2 = "b8bb26";
        bright3 = "fabd2f";
        bright4 = "83a598";
        bright5 = "d3869b";
        bright6 = "8ec07c";
        bright7 = "ebdbb2";
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
    settings = {
      character = {
        success_symbol = "[󰄾󰇼](bold green)";
        error_symbol = "[󰄾󰇼](bold red)";
        vimcmd_symbol = "[󰇼󰄽](bold green)";
      };
    };
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

  services.flatpak = {
    enable = true;
    packages = [
      "com.valvesoftware.Steam"
      "com.viber.Viber"
    ];
  };
}
