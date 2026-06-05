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

    # rust stable
    (fenix.packages.${pkgs.stdenv.hostPlatform.system}.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rust-analyzer"
    ])
    # rust nightly
    (fenix.packages.${pkgs.stdenv.hostPlatform.system}.default.withComponents [
      "rustfmt"
    ])
  ];
}
