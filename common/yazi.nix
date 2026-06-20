{...}: {
  programs.yazi = {
    enable = true;
    settings = {
      preview = {
        max_width = 2000;
        max_height = 2000;
      };
    };
  };
}
