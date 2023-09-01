{ pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
  };
}
