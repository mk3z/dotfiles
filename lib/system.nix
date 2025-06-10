{
  user,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  mkHost = {
    systemConfig,
    userConfig ? {},
    extraModules ? [],
  }: let
    inherit (systemConfig.core) hostname;
  in
    nixosSystem {
      specialArgs = {
        inherit inputs;
        sysPersistDir = "/persist";
      };

      modules =
        [
          ({config, ...}: let
            inherit (config.mkez.core) server;
            inherit (config.mkez.user) username;
          in {
            imports = [
              ../hosts/${hostname}
              ../modules/system
            ];

            mkez = systemConfig;

            home-manager =
              if !server
              then {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                users.${username} = user.mkConfig {inherit userConfig;};
                backupFileExtension = "hmbak";
              }
              else {};
          })

          inputs.home-manager.nixosModule
          inputs.impermanence.nixosModule
          inputs.disko.nixosModules.disko
          inputs.agenix.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ]
        ++ extraModules;
    };
}
