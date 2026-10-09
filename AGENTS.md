# Repository directives

- When the user asks to configure Omarchy, codify the requested change in
  this dotfiles repository as part of the same task. Use `tag-omarchy/` and
  `rcrc.omarchy` for personal overrides, and document required setup steps
  when a change cannot be represented by a dotfile alone. Apply and validate
  the configuration as appropriate; do not leave the customization only in
  the live system configuration.
- This repository is used on multiple platforms, including macOS and Linux.
  Do not assume Linux or Omarchy is the only target. Keep platform-specific
  configuration and setup isolated in the appropriate profiles, preserve
  support for other platforms, and guard shared scripts when behavior differs
  by platform. The default `rcrc` and `install` script target macOS;
  `rcrc.omarchy` targets Omarchy.
