{...}: {
  programs.rofi = {
    enable = true;

    theme = "iggy";

    settings = {
      terminal = "alacritty";

      show-icons = true;
      icon-theme = "Papirus";
    };
  };
}
