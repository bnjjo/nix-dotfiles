{...}: {
  programs.fd = {
    enable = true;
    ignores = [
      ".cache/"
      ".direnv/"
      ".DS_Store"
      ".Trash/"
      "Applications/"
      "Library/"
      "nix/"
      "result/"
    ];
  };
}
