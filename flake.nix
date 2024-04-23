{
  inputs = {
    nixpkgs.url = "nixpkgs";
    hyprcursor.url = "github:hyprwm/hyprcursor";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, hyprcursor, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ hyprcursor.outputs.overlays.default ];
        };
      in {
        devShell = pkgs.mkShell {
          name = "devshell";
          packages = [ pkgs.hyprcursor pkgs.xcur2png ];
        };
      });
}
