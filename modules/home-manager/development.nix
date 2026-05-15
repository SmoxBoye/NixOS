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
    beamMinimal28Packages.elixir_1_19

    godot

    nodejs # i thought i would never see the day honestly
    prettier
    # vue-language-server
    # typescript-language-server
    #
    wev
    yt-dlp
    ripgrep

    llama-cpp
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
      nos = "nh os switch $NIXCONFDIR --ask --max-jobs 10";
      nosu = "nh os switch $NIXCONFDIR --update --ask --max-jobs 10";
      nob = "nh os boot $NIXCONFDIR --ask --max-jobs 10";
      nobu = "nh os boot $NIXCONFDIR --ask --update --max-jobs 10";
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

      k3() {
        local cmd_string="$1"

        # If no command is provided, just open 3 blank kitties
        if [ -z "$cmd_string" ]; then
            cmd_string="exec bash"
        else
            # Ensure it ends with a shell so the window stays open
            cmd_string="$cmd_string; exec bash"
        fi

        for i in {1..3}; do
            kitty bash -c "$cmd_string" &
        done
      }
    '';
    profileExtra = ''
      if [[ "$(tty)" == "/dev/tty1" ]]; then
        exec start-hyprland
      fi
    '';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

}
