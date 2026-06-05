{...}: {
  programs.fd = {
    enable = true;
    ignores = [
      "Applications/"
      "Library/"
      ".Trash/"
      ".cache/"
      ".DS_Store"
    ];
  };
}
