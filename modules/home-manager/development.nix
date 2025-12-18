{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    lazygit
    uv
    nil
    nixfmt-rfc-style
  ];

  # Clone dotfiles repo to home directory
  home.activation.cloneHelixDotfiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.config/helix" ]; then
      ${pkgs.git}/bin/git clone https://github.com/SmoxBoye/helix-config.git "$HOME/.config/helix"
    fi
  '';

  programs.helix = {
    enable = true;
    # Configuration will be loaded from ~/.config/helix/
  };
}
