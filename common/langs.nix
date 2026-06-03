{
  pkgs,
  fenix,
  ...
}: {
  home.packages = with pkgs; [
    # nix
    nil
    alejandra

    # lua
    lua-language-server
    stylua

    # rust
    (fenix.packages.${pkgs.system}.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rust-analyzer"
    ])
    (fenix.packages.${pkgs.system}.default.withComponents [
      "rustfmt"
    ])
  ];
}
