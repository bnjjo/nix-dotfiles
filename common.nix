{...}: {
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.fd = {
    enable = true;
    ignores = [
      "Library/"
      ".Trash/"
      ".cache/"
      ".DS_Store"
    ];
  };
  programs.ripgrep.enable = true;
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
        source.command = "fd -t f . ~/nix-dotfiles";
        preview.command = "bat -n --color=always '{}'";
        keybindings.enter = "actions:edit";
        actions.edit = {
          description = "Edit the selected dotfile";
          command = "nvim '{}' -c 'cd ~/nix-dotfiles'";
          mode = "execute";
        };
      };
    };
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    historyLimit = 50000;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    terminal = "ghostty";
    extraConfig = ''
      set -ga terminal-overrides ",ghostty:Tc"

      # pane base index
      setw -g pane-base-index 1

      # splits
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # session/window/pane management
      bind N new-session
      bind x kill-pane
      bind & kill-window

      # pane navigation
      bind-key -n C-h select-pane -L
      bind-key -n C-j select-pane -D
      bind-key -n C-k select-pane -U
      bind-key -n C-l select-pane -R

      # window navigation
      bind-key -n S-Left previous-window
      bind-key -n S-Right next-window

      # vi copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      # mouse scroll behavior (was tmux-better-mouse-mode)
      set -g @scroll-speed-num-lines-per-scroll "1"

      # reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "[!] reloaded"

      # statusbar
      set -g status-right ""
      set -g status-style bg=default,fg=brightgreen
    '';
  };
}
