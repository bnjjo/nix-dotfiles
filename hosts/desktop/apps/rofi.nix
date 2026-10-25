{...}: {
  programs.rofi = {
    enable = true;

    theme = "iggy";

    extraConfig = {
      terminal = "alacritty";

      show-icons = true;
      icon-theme = "Papirus";
    };
  };
}
