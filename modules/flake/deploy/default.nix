{
  self,
  inputs,
  ...
}: {
  flake = {
    deploy.nodes = {
      bastion = {
        hostname = "bastion.intra.mkez.fi";
        sshUser = "root";
        remoteBuild = true;
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.bastion;
        };
      };

      nas = {
        hostname = "nas.intra.mkez.fi";
        sshUser = "root";
        fastConnection = true;
        remoteBuild = true;
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nas;
        };
      };
    };

    checks = builtins.mapAttrs (_system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}
