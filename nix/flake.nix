{
  description = "Minimal NixOS flake (unstable) with hostname & username vars";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";

    # Define reusable variables
    hostname = "satrix";
    username = "sten";

    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit hostname username;
      };
      modules = [ ./configuration.nix ];
    };
  };
}
