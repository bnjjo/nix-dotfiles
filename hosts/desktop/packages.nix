{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./apps/i3.nix
    ./apps/picom.nix
    ./apps/starship.nix
    ../../common/bat.nix
    ../../common/eza.nix
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
    alacritty
    brightnessctl
    chafa
    fastfetch
    gcc
    jellyfin-mpv-shim
    gnumake
    mpv
    neovim
    nix-search-tv
    playerctl
    rofi
    unzip
    tree-sitter
    xclip

    # this is unfortunately all needed for viber...
    (pkgs.buildFHSEnv {
      name = "viber";
      targetPkgs = pkgs: [
        (pkgs.viber.overrideAttrs (old: {
          postFixup =
            (old.postFixup or "")
            + ''
              rm -f $out/opt/viber/lib/libxml2.so.2
              ln -s ${pkgs.libxml2_13.out}/lib/libxml2.so.2 $out/opt/viber/lib/libxml2.so.2
            '';
        }))
        pkgs.libxshmfence
        pkgs.libxcb-cursor
        pkgs.xcbutil
        pkgs.pipewire
      ];
      runScript = "viber";
      extraInstallCommands = ''
        mkdir -p $out/share/applications
        cp ${pkgs.viber}/share/applications/viber.desktop $out/share/applications/
        sed -i "s|Exec=.*|Exec=$out/bin/viber|" $out/share/applications/viber.desktop
        sed -i "/^Path=/d" $out/share/applications/viber.desktop
      '';
    })

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
