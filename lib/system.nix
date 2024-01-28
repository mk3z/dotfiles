{
  user,
  inputs,
  ...
}: let
  username = "matias";
  homeDirectory = "/home/${username}";
  homePersistDir = "/persist";
  inherit (inputs.nixpkgs) lib;
in {
  mkHost = {
    systemConfig,
    userConfig,
  }:
    lib.nixosSystem {
      specialArgs = {
        inherit inputs username homeDirectory homePersistDir;
        sysPersistDir = "/persist";
      };

      modules = [
        {
          imports = [
            ../hosts/${systemConfig.core.hostname}
            ../modules/system
          ];

          mkez = systemConfig;

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs username homeDirectory homePersistDir;
            };
            users.${username} = user.mkConfig {inherit userConfig;};
          };
        }

        inputs.home-manager.nixosModule
        inputs.impermanence.nixosModule
        inputs.agenix.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };
}
