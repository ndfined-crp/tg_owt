{
  nixConfig = {
    extra-substituters = ["https://ayugram-desktop.cachix.org"];
    extra-trusted-public-keys = ["ayugram-desktop.cachix.org-1:AZ5EqHrJsAKL5YkZYLPEsb1FdD9QlypUwQ0REcJftgA="];
  };

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = inputs: let
    inherit (inputs) nixpkgs;

    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
  in {
    packages = forEachSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      tg_owt = pkgs.callPackage ./default.nix {};
    in {
      inherit tg_owt;
      default = tg_owt;
    });
  };
}
