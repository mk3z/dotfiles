{
  user,
  inputs,
  ...
}: let
  username = "mkez";
  homeDirectory = "/home/${username}";
  homePersistDir = "/persist";
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  mkHost = {
    extraModules,
    systemConfig,
    userConfig ? {},
  }:
    nixosSystem {
      specialArgs = {
        inherit inputs username homeDirectory homePersistDir;
        sysPersistDir = "/persist";
      };

      modules =
        [
          {
            imports = [
              ../hosts/${systemConfig.core.hostname}
              ../modules/system
            ];

            mkez = systemConfig;

            home-manager =
              if !systemConfig.core.server
              then {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs username homeDirectory homePersistDir;
                };
                users.${username} = user.mkConfig {inherit userConfig;};
              }
              else {};
          }

          inputs.home-manager.nixosModule
          inputs.impermanence.nixosModule
          inputs.agenix.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ]
        ++ extraModules;
    };
}
