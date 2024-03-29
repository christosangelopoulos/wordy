{
  description = "Wordy is a TUI word spelling puzzle in bash. You have 6 guesses to find out the secret 5-letter word.";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.wordy = pkgs.callPackage ./default.nix { };

      packages.default = self.packages.${system}.wordy;
    });
}
