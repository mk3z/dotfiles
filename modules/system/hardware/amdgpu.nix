{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.hardware.amdgpu;
in {
  options.mkez.hardware.amdgpu.enable = mkEnableOption "Enable AMDGPU drivers and kernel module";

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = ["amdgpu"];

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [rocm-opencl-icd rocm-opencl-runtime];
    };
  };
}