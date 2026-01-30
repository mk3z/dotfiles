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
    sysPersistDir ? "/persist",
    extraModules ? [],
  }: let
    inherit (systemConfig.core) hostname;
  in
    nixosSystem {
      specialArgs = {inherit inputs sysPersistDir;};

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
                overwriteBackup = true;
              }
              else {};
          })

          inputs.agenix.nixosModules.default
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          inputs.impermanence.nixosModule
          inputs.lanzaboote.nixosModules.lanzaboote
          inputs.stylix.nixosModules.stylix
        ]
        ++ extraModules;
    };
}
