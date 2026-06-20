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
    cliphist
    fastfetch
    gcc
    gnumake
    grim
    jellyfin-mpv-shim
    mako
    mpv
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
      start-dwl = "~/nix-dotfiles/hosts/desktop/suckless/slstatus/result/bin/slstatus -s | ~/nix-dotfiles/hosts/desktop/suckless/dwl/result/bin/dwl";
    };
    initContent = ''
      bindkey -v
      export EDITOR=nvim
      export VISUAL=nvim
    '';
  };

  services.flatpak = {
    enable = true;
    packages = [
      "com.valvesoftware.Steam"
      "com.viber.Viber"
    ];
  };
}
