{...}: {
  programs.television = {
    enable = true;
    enableZshIntegration = true;
    settings = {};
    channels = {
      nix = {
        metadata = {
          name = "nix";
          requirements = ["nix-search-tv"];
        };
        source.command = "nix-search-tv print";
        preview.command = "nix-search-tv preview {}";
      };
      dotfiles = {
        metadata = {
          name = "dotfiles";
          description = "Browse nix dotfiles";
          requirements = ["fd" "bat"];
        };
        source.command = "fd -t f --base-directory ~/nix-dotfiles";
        preview.command = "bat -n --color=always ~/nix-dotfiles/'{}'";
        keybindings.enter = "actions:edit";
        actions.edit = {
          description = "Edit the selected dotfile";
          command = "nvim ~/nix-dotfiles/'{}' -c 'cd ~/nix-dotfiles'";
          mode = "execute";
        };
      };
      nvim = {
        metadata = {
          name = "nvim";
          description = "Browse neovim dotfiles";
          requirements = ["fd" "bat"];
        };
        source.command = "fd -t f --no-ignore-vcs . ~/.config/nvim";
        preview.command = "bat -n --color=always '{}'";
        keybindings.enter = "actions:edit";
        actions.edit = {
          description = "Edit the selected dotfile";
          command = "nvim '{}' -c 'cd ~/.config/nvim'";
          mode = "execute";
        };
      };
    };
  };
}
