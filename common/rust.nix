{
  pkgs,
  fenix,
  ...
}: {
  nixpkgs.overlays = [fenix.overlays.default];
  environment.systemPackages = [
    (pkgs.fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
    ])
    (pkgs.fenix.default.withComponents [
      "rustfmt"
    ])
  ];
}
