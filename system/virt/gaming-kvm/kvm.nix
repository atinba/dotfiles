{ pkgs, config, lib, ... }:

with lib; let
  cfg = config.virtualisation.gaming-kvm;

  vfio_kernel_modules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"
  ];

  nvidia_kernel_modules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

in
{
  options.virtualisation.gaming-kvm = {
    enable = lib.mkEnableOption "Gaming KVM via GPU Passthrough";

    iommu_type = mkOption {
      type = types.enum [ "intel" "amd" ];
    };

    gpu_pci_ids = mkOption {
      type = types.listOf (types.strMatching "[0-9a-f]{4}:[0-9a-f]{4}");
      description = "PCI IDs of devices to bind to vfio-pci.";
    };


  };

  config = lib.mkIf cfg.enable {
    #    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;

    boot = {
      kernelParams = [
        "intel_iommu=on"
        "intel_iommu=igfx_off"
        ("vfio-pci.ids=" + builtins.concatStringsSep
          ","
          cfg.gpu_pci_ids)
      ];

      #      initrd.kernelModules = vfio_kernel_modules ++ nvidia_kernel_modules;
    };

    #  hardware.nvidia.prime = {
    #    offload.enable = true;
    #    intelBusId = "PCI:01:31:0";
    #    nvidiaBusId = "PCI:01:00:0";
    #  };

    users.groups.libvirtd.members = [ "root" "atin" ];
    virtualisation = {
      lxc.enable = true;
      lxd.enable = true;
      libvirtd = {
        enable = true;
        onBoot = "ignore";
        onShutdown = "shutdown";
        qemu = {
          runAsRoot = true;
          ovmf.enable = true;
          package = pkgs.qemu_kvm;
        };
      };
      spiceUSBRedirection.enable = true; # USB passthrough
    };

    environment = {
      systemPackages = with pkgs; [
        nvidia-offload
        virt-manager
        virt-viewer
        qemu
        qemu_kvm
        OVMF
        gvfs # Used for shared folders between linux and windows
      ];
    };

    services = {
      # Enable file sharing between OS
      gvfs.enable = true;
    };
  };
}
