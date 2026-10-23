# tg_owt

Nix flake for [tg_owt](https://github.com/desktop-app/tg_owt), the WebRTC fork used by Telegram Desktop.

## Usage

```console
$ nix build
```

Or as a flake input:

```nix
inputs.tg_owt.url = "github:ndfined-crp/tg_owt";

# ...
buildInputs = [
  inputs.tg_owt.packages.${pkgs.system}.tg_owt
];
```
