{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Essential system packages for Hyprland and Wayland
  environment.systemPackages = with pkgs; [
    hyprpolkitagent # Polkit agent for Hyprland
    noto-fonts # Font family for proper text rendering
    font-awesome
    hyprcursor
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    hyprlang
    # hyprshutdown
  ];

  # Font configuration for proper text rendering
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Noto Sans Mono" ];
      };
    };
  };
}
