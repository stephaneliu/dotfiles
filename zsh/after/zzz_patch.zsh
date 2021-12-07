# Fixes this (bug)[https://github.com/asdf-vm/asdf/issues/1103] in asdf ohmyzsh plugin when upgrading asdf
# from 0.8.1 to 0.9.1
# Safely remove when [PR](https://github.com/ohmyzsh/ohmyzsh/pull/10481) is merged
export ASDF_DIR="$(brew --prefix asdf)/libexec"
