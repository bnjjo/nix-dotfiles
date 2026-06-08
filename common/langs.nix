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
    (fenix.packages.${pkgs.stdenv.hostPlatform.system}.combine [
      (fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rust-analyzer"
      ])
      fenix.packages.${pkgs.stdenv.hostPlatform.system}.default.rustfmt
    ])
  ];
}
