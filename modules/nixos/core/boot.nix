{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://wiki.nixos.org/wiki/OBS_Studio
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [
    "v4l2loopback"
    "ntsync"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];
  security.polkit.enable = true;

  # Use latest kernel.
  # nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  # boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_19;
}
