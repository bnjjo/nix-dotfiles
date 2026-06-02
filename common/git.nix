{...}: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "bnjjo";
      user.email = "131111426+bnjjo@users.noreply.github.com";
      init.defaultBranch = "main";
    };
  };
}
