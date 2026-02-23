{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    lazygit
    uv
    cudaPackages.cudnn
    nil
    nixfmt
    nerd-fonts.jetbrains-mono
    kdePackages.qtdeclarative
  ];

  # Clone dotfiles repo to home directory
  home.activation.cloneHelixDotfiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.config/helix" ]; then
      ${pkgs.git}/bin/git clone git@github.com:SmoxBoye/helix-config.git "$HOME/.config/helix"
    fi
  '';

  programs.helix = {
    enable = true;
    # Configuration will be loaded from ~/.config/helix/
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      # Old nix commands
      nbs = "sudo nixos-rebuild switch --flake $NIXCONFDIR";
      nbb = "sudo nixos-rebuild boot --flake $NIXCONFDIR";
      nbu = "sudo nixos-rebuild switch --upgrade --flake $NIXCONFDIR";
      # New nix commands
      nfu = "sudo nix flake update --flake $NIXCONFDIR";
      nos = "nh os switch $NIXCONFDIR --ask";
      nosu = "nh os switch $NIXCONFDIR --update --ask";
      nhs = "nh home switch $NIXCONFDIR --ask";
      nca = "nh clean all -n -k 5 -K 7d";
      # haha funny
      bruh = "uvx pycowsay Brrrrrrrrrrrrrrrrrrrrrrrr";
      nconf = "hx $NIXCONFDIR";
      skibiditoilet = "uvx pycowsay Skibidi Toilet";
      PENIS = "uvx pycowsay Skill issue";
    };
    sessionVariables = {
      NIXCONFDIR = "$HOME/myflake";
    };
    bashrcExtra = ''
      hyprreload() {
        pkill "$1" && hyprctl dispatch exec "$1"
      }

      ns() {
        nh search --limit 5 "$1"
      }
    '';
    profileExtra = ''
      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec start-hyprland
      fi
    '';
  };
}
