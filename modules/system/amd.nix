{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.hw.amd;
  kver = config.boot.kernelPackages.kernel.version;
in {
  options.hw.amd.enable = mkEnableOption "Enable AMD-specific kernel parameters and modules";
  config = mkIf cfg.enable {
    # Enables the amd cpu scaling https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
    # On recent AMD CPUs this can be more energy efficient.
    boot = lib.mkMerge [
      (lib.mkIf
        (
          (lib.versionAtLeast kver "5.17")
          && (lib.versionOlder kver "6.1")
        )
        {
          kernelParams = ["initcall_blacklist=acpi_cpufreq_init"];
          kernelModules = ["amd-pstate"];
        })
      (lib.mkIf
        (
          (lib.versionAtLeast kver "6.1")
          && (lib.versionOlder kver "6.3")
        )
        {
          kernelParams = ["amd_pstate=passive"];
        })
      (lib.mkIf (lib.versionAtLeast kver "6.3") {
        kernelParams = ["amd_pstate=active"];
      })
    ];
  };
}
