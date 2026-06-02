{...}: {
  programs.fd = {
    enable = true;
    ignores = [
      "Library/"
      ".Trash/"
      ".cache/"
      ".DS_Store"
    ];
  };
}
