{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager settings
  home.username = "smoxboye";
  home.homeDirectory = "/home/smoxboye";
  home.stateVersion = "25.11";

  # Enable programs
  programs.home-manager.enable = true;

  # Import Home Manager modules
  imports = [
    ./modules/home-manager/browser.nix
    ./modules/home-manager/development.nix
    ./modules/home-manager/terminal.nix
    ./modules/home-manager/desktop.nix
    ./modules/home-manager/communication.nix
    ./modules/home-manager/hyprland/hyprland.nix
    ./modules/home-manager/hyprland/ashell.nix
    ./modules/home-manager/deltatune.nix
    ./modules/home-manager/obs.nix
    ./modules/home-manager/OpenComposite.nix
  ];
}
