{
  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://tg-owt.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "tg-owt.cachix.org-1:lp0BukIhSK3EIyLcDhDZ5zABgT48nmNp6t4SnZ0wr8w="
    ];
  };

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = inputs: let
    inherit (inputs) nixpkgs;

    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
  in {
    packages = forEachSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      tg_owt = pkgs.callPackage ./default.nix {};
    });
  };
}
