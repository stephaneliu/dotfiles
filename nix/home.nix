{ config, pkgs, ... }:

{
  # Required settings
  home.username = "sliu";
  home.homeDirectory = "/Users/sliu";
  home.stateVersion = "24.11";

  # User packages (replaces brew install for CLI tools)
  home.packages = with pkgs; [
    ripgrep
  ];

  # Example: git configuration (we'll migrate your gitconfig here later)
  # programs.git = {
  #   enable = true;
  #   userName = "Your Name";
  #   userEmail = "you@example.com";
  # };
}