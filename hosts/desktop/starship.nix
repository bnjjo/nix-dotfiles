{...}: {
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
}
