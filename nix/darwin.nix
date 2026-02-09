{ pkgs, ... }:

{
  # System packages available to all users
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
  ];

  # Enable Nix daemon
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Shell - required for nix-darwin
  programs.zsh.enable = true;

  # Homebrew - keep existing setup, manage declaratively
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;        # Don't auto-update on switch
      cleanup = "none";          # Don't remove anything yet
    };
    # Later you'll move casks/brews here from Brewfile
  };

  # macOS system defaults (replaces your osx-settings script)
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;        # Don't rearrange spaces by recent use
      show-recents = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";  # Column view
      ShowPathbar = true;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 14;
      KeyRepeat = 1;
      "com.apple.swipescrolldirection" = true;  # Natural scrolling on
    };
  };

  # Used for backwards compatibility
  system.stateVersion = 5;
}
