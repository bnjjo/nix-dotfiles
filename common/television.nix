{...}: {
  programs.television = {
    enable = true;
    enableNushellIntegration = true;
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
          description = "Edit the selected neovim config file";
          command = "nvim '{}' -c 'cd ~/.config/nvim'";
          mode = "execute";
        };
      };
      org = {
        metadata = {
          name = "org";
          description = "Browse org-mode files";
          requirements = ["fd" "bat"];
        };
        source.command = "fd -t f . ~/orgfiles";
        preview.command = "bat -n --color=always '{}'";
        keybindings.enter = "actions:edit";
        actions.edit = {
          description = "Edit the selected org file";
          command = "nvim '{}' -c 'cd ~/orgfiles'";
          mode = "execute";
        };
      };
      projects = {
        metadata = {
          name = "projects";
          description = "Select from git repositories on your local machine";
          requirements = ["fd" "git"];
        };
        source = {
          command = "fd -g .git -HL -t d -d 10 --prune ~ -E 'Library' -E 'Application Support' --exec dirname '{}'";
          display = "{split:/:-1}";
        };
        preview.command = "cd '{}'; git log -n 200 --pretty=medium --all --graph --color";
        keybindings = {
          shift-enter = "actions:cd";
          ctrl-e = "actions:edit";
        };
        actions.cd = {
          description = "Open a new shell in the selected repository";
          command = "cd {} && $SHELL";
          shell = "bash";
          mode = "execute";
        };
        actions.edit = {
          description = "Open the repository in editor";
          command = "\${EDITOR:-vim} {}";
          shell = "bash";
          mode = "execute";
        };
      };
    };
  };
}
