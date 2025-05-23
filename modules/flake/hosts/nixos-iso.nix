{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    nixos-iso = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules;
        [
          common-pc
        ]
        ++ [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ];

      systemConfig = {
        core = {
          hostname = "nixos-iso";
          server = false;
        };
        user.noPassword = true;
      };

      userConfig = {
        gui = {
          wm.primary = "niri";
          launcher.primary = "fuzzel";
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
