#!/bin/sh
#
# Usage:
#
#    sh install.sh
#
# Environment variables: VERBOSE, CP, LN, MKDIR, RM, DIRNAME.
#
#    env VERBOSE=1 sh install.sh
#
# DO NOT EDIT THIS FILE
# 
# This file is generated by rcm(7) as:
#
#   rcup -fv -B 0 -g
#
# To update it, re-run the above command.
#
: ${VERBOSE:=1}
: ${CP:=/bin/cp}
: ${LN:=/bin/ln}
: ${MKDIR:=/bin/mkdir}
: ${RM:=/bin/rm}
: ${DIRNAME:=/usr/bin/dirname}
verbose() {
  if [ "$VERBOSE" -gt 0 ]; then
    echo "$@"
  fi
}
handle_file_cp() {
  if [ -e "$2" ]; then
    printf "%s " "overwrite $2? [yN]"
    read overwrite
    case "$overwrite" in
      y)
        $RM -rf "$2"
        ;;
      *)
        echo "skipping $2"
        return
        ;;
    esac
  fi
  verbose "'$1' -> '$2'"
  $MKDIR -p "$($DIRNAME "$2")"
  $CP -R "$1" "$2"
}
handle_file_ln() {
  if [ -e "$2" ]; then
    printf "%s " "overwrite $2? [yN]"
    read overwrite
    case "$overwrite" in
      y)
        $RM -rf "$2"
        ;;
      *)
        echo "skipping $2"
        return
        ;;
    esac
  fi
  verbose "'$1' -> '$2'"
  verbose "mkdir $($DIRNAME "$2")"
  $MKDIR -p "$($DIRNAME "$2")"
  $LN -sf "$1" "$2"
}
echo "*** PWD: $PWD"
echo "which ln: $(which ln)"

handle_file_ln "$PWD/.dotfiles/tag-git/git-template/commit_template.txt" "~/.git-template/commit_template.txt"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/lolcommits" "~/.git-template/hooks/lolcommits"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/post-checkout" "~/.git-template/hooks/post-checkout"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/post-commit" "~/.git-template/hooks/post-commit"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/post-merge" "~/.git-template/hooks/post-merge"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/post-rewrite" "~/.git-template/hooks/post-rewrite"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/pre-commit" "~/.git-template/hooks/pre-commit"
handle_file_ln "$PWD/.dotfiles/tag-git/git-template/hooks/pre-rebase" "~/.git-template/hooks/pre-rebase"
handle_file_ln "$PWD/.dotfiles/tag-git/gitattributes" "~/.gitattributes"
handle_file_ln "$PWD/.dotfiles/tag-git/gitconfig" "~/.gitconfig"
handle_file_ln "$PWD/.dotfiles/tag-git/gitignore" "~/.gitignore"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/conflicted.vim" "~/.vim/rcplugins/conflicted.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/endwise.vim" "~/.vim/rcplugins/endwise.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/fugitive.vim" "~/.vim/rcplugins/fugitive.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/gist.vim" "~/.vim/rcplugins/gist.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/git.vim" "~/.vim/rcplugins/git.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/gitgutter.vim" "~/.vim/rcplugins/gitgutter.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/nvim_blame_line.vim" "~/.vim/rcplugins/nvim_blame_line.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/vim/rcplugins/vim_gh_line.vim" "~/.vim/rcplugins/vim_gh_line.vim"
handle_file_ln "$PWD/.dotfiles/tag-git/zsh/after/completion.zsh" "~/.zsh/after/completion.zsh"
handle_file_ln "$PWD/.dotfiles/tag-git/zsh/git.zsh" "~/.zsh/git.zsh"
handle_file_ln "$PWD/.dotfiles/tag-git/zsh/lol.zsh" "~/.zsh/lol.zsh"
handle_file_ln "$PWD/.dotfiles/tag-ruby/default-gems" "~/.default-gems"
handle_file_ln "$PWD/.dotfiles/tag-ruby/editrc" "~/.editrc"
handle_file_ln "$PWD/.dotfiles/tag-ruby/gemrc" "~/.gemrc"
handle_file_ln "$PWD/.dotfiles/tag-ruby/irbrc" "~/.irbrc"
handle_file_ln "$PWD/.dotfiles/tag-ruby/pryrc" "~/.pryrc"
handle_file_ln "$PWD/.dotfiles/tag-ruby/railsrc" "~/.railsrc"
handle_file_ln "$PWD/.dotfiles/tag-ruby/rdebugrc" "~/.rdebugrc"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/ale_ruby.vim" "~/.vim/rcplugins/ale_ruby.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/bundler.vim" "~/.vim/rcplugins/bundler.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/haml.vim" "~/.vim/rcplugins/haml.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/projectionist.vim" "~/.vim/rcplugins/projectionist.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/rails.vim" "~/.vim/rcplugins/rails.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/rake.vim" "~/.vim/rcplugins/rake.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/rspec.vim" "~/.vim/rcplugins/rspec.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/rubocop.vim" "~/.vim/rcplugins/rubocop.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/ruby.vim" "~/.vim/rcplugins/ruby.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/ruby_refactoring.vim" "~/.vim/rcplugins/ruby_refactoring.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/syntastic_ruby.vim" "~/.vim/rcplugins/syntastic_ruby.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/rcplugins/vim-rspec.vim" "~/.vim/rcplugins/vim-rspec.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/vim/ruby_abbreviations.vim" "~/.vim/ruby_abbreviations.vim"
handle_file_ln "$PWD/.dotfiles/tag-ruby/zsh/ruby.zsh" "~/.zsh/ruby.zsh"
handle_file_ln "$PWD/.dotfiles/tag-tmux/tmux.conf" "~/.tmux.conf"
handle_file_ln "$PWD/.dotfiles/tag-tmux/vim/rcplugins/tmux.vim" "~/.vim/rcplugins/tmux.vim"
handle_file_ln "$PWD/.dotfiles/tag-tmux/zsh/tmux.zsh" "~/.zsh/tmux.zsh"
handle_file_ln "$PWD/.dotfiles/Brewfile" "~/Brewfile"
handle_file_ln "$PWD/.dotfiles/Brewfile.lock.json" "~/.Brewfile.lock.json"
handle_file_ln "$PWD/.dotfiles/agignore" "~/.agignore"
handle_file_ln "$PWD/.dotfiles/bin/24-bit-colors-test.sh" "~/bin/24-bit-colors-test.sh"
handle_file_ln "$PWD/.dotfiles/bin/256-colors.sh" "~/bin/256-colors.sh"
handle_file_ln "$PWD/.dotfiles/bin/link_rails_intellisense" "~/bin/link_rails_intellisense"
handle_file_ln "$PWD/.dotfiles/bin/plist" "~/bin/plist"
handle_file_ln "$PWD/.dotfiles/bin/psgrep" "~/bin/psgrep"
handle_file_ln "$PWD/.dotfiles/bin/ray" "~/bin/ray"
handle_file_ln "$PWD/.dotfiles/bin/silence_ruby" "~/bin/silence_ruby"
handle_file_ln "$PWD/.dotfiles/config/cheat/cheatsheets/personal/ruby" "~/.config/cheat/cheatsheets/personal/ruby"
handle_file_ln "$PWD/.dotfiles/config/cheat/conf.yml" "~/.config/cheat/conf.yml"
handle_file_ln "$PWD/.dotfiles/config/gitui/key_config.ron" "~/.config/gitui/key_config.ron"
handle_file_ln "$PWD/.dotfiles/config/kitty/current-theme.conf" "~/.config/kitty/current-theme.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/font.conf" "~/.config/kitty/font.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/grab.conf" "~/.config/kitty/grab.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/hints.conf" "~/.config/kitty/hints.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty.conf" "~/.config/kitty/kitty.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/LICENSE" "~/.config/kitty/kitty_grab/LICENSE"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/_grab_ui.py" "~/.config/kitty/kitty_grab/_grab_ui.py"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/grab-vim.conf.example" "~/.config/kitty/kitty_grab/grab-vim.conf.example"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/grab.conf.example" "~/.config/kitty/kitty_grab/grab.conf.example"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/grab.py" "~/.config/kitty/kitty_grab/grab.py"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/kitten_options_definition.py" "~/.config/kitty/kitty_grab/kitten_options_definition.py"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/kitten_options_parse.py" "~/.config/kitty/kitty_grab/kitten_options_parse.py"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/kitten_options_types.py" "~/.config/kitty/kitty_grab/kitten_options_types.py"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/kitten_options_utils.py" "~/.config/kitty/kitty_grab/kitten_options_utils.py"
handle_file_ln "$PWD/.dotfiles/config/kitty/kitty_grab/kitty.conf.example" "~/.config/kitty/kitty_grab/kitty.conf.example"
handle_file_ln "$PWD/.dotfiles/config/kitty/scrollback.conf" "~/.config/kitty/scrollback.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/splits.conf" "~/.config/kitty/splits.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/tabs.conf" "~/.config/kitty/tabs.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/theme.conf" "~/.config/kitty/theme.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/themes/solarized-dark.conf" "~/.config/kitty/themes/solarized-dark.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/themes/solarized-light.conf" "~/.config/kitty/themes/solarized-light.conf"
handle_file_ln "$PWD/.dotfiles/config/kitty/visual.conf" "~/.config/kitty/visual.conf"
handle_file_ln "$PWD/.dotfiles/config/nvim/init.vim" "~/.config/nvim/init.vim"
handle_file_ln "$PWD/.dotfiles/config/tmuxinator/cc.yml" "~/.config/tmuxinator/cc.yml"
handle_file_ln "$PWD/.dotfiles/ctags" "~/.ctags"
handle_file_ln "$PWD/.dotfiles/dir_colors" "~/.dir_colors"
handle_file_ln "$PWD/.dotfiles/inputrc" "~/.inputrc"
handle_file_ln "$PWD/.dotfiles/install.sh" "~/.install.sh"
handle_file_ln "$PWD/.dotfiles/p10k.zsh" "~/.p10k.zsh"
handle_file_ln "$PWD/.dotfiles/rcrc" "~/.rcrc"
handle_file_ln "$PWD/.dotfiles/ssh/config" "~/.ssh/config"
handle_file_ln "$PWD/.dotfiles/tmux/bindings.tmux" "~/.tmux/bindings.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/modifier.tmux" "~/.tmux/modifier.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/pbcopy_paste.tmux" "~/.tmux/pbcopy_paste.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/plugins.tmux" "~/.tmux/plugins.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/status_bar.tmux" "~/.tmux/status_bar.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/system.tmux" "~/.tmux/system.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/true_color_tmux_vim_support.tmux" "~/.tmux/true_color_tmux_vim_support.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/vi_mode.tmux" "~/.tmux/vi_mode.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/vim_tmux_navigator.tmux" "~/.tmux/vim_tmux_navigator.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/visual.tmux" "~/.tmux/visual.tmux"
handle_file_ln "$PWD/.dotfiles/tmux/zsh.tmux" "~/.tmux/zsh.tmux"
handle_file_ln "$PWD/.dotfiles/tool-versions" "~/.tool-versions"
handle_file_ln "$PWD/.dotfiles/vim/autocmd.vim" "~/.vim/autocmd.vim"
handle_file_ln "$PWD/.dotfiles/vim/backups" "~/.vim/backups"
handle_file_ln "$PWD/.dotfiles/vim/bundle" "~/.vim/bundle"
handle_file_ln "$PWD/.dotfiles/vim/clipboard.vim" "~/.vim/clipboard.vim"
handle_file_ln "$PWD/.dotfiles/vim/gui.vim" "~/.vim/gui.vim"
handle_file_ln "$PWD/.dotfiles/vim/kitty.vim" "~/.vim/kitty.vim"
handle_file_ln "$PWD/.dotfiles/vim/marked_2.vim" "~/.vim/marked_2.vim"
handle_file_ln "$PWD/.dotfiles/vim/number_toggle.vim" "~/.vim/number_toggle.vim"
handle_file_ln "$PWD/.dotfiles/vim/nvim_lsp_config_solargraph.vim" "~/.vim/nvim_lsp_config_solargraph.vim"
handle_file_ln "$PWD/.dotfiles/vim/nvim_lsp_config_tw.vim" "~/.vim/nvim_lsp_config_tw.vim"
handle_file_ln "$PWD/.dotfiles/vim/options.vim" "~/.vim/options.vim"
handle_file_ln "$PWD/.dotfiles/vim/quickfix.vim" "~/.vim/quickfix.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/ack.vim" "~/.vim/rcplugins/ack.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/addon_mw_utils.vim" "~/.vim/rcplugins/addon_mw_utils.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/ag.vim" "~/.vim/rcplugins/ag.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/airline.vim" "~/.vim/rcplugins/airline.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/ale.vim" "~/.vim/rcplugins/ale.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/calendar.vim" "~/.vim/rcplugins/calendar.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/camelcasemotion.vim" "~/.vim/rcplugins/camelcasemotion.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/closetag.vim" "~/.vim/rcplugins/closetag.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/colors.vim" "~/.vim/rcplugins/colors.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/copilot.vim" "~/.vim/rcplugins/copilot.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/ctrlp.vim" "~/.vim/rcplugins/ctrlp.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/dash.vim" "~/.vim/rcplugins/dash.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/devicons.vim" "~/.vim/rcplugins/devicons.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/dispatch.vim" "~/.vim/rcplugins/dispatch.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/indent_line.vim" "~/.vim/rcplugins/indent_line.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/javascript.vim" "~/.vim/rcplugins/javascript.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/kitty_navigator.vim" "~/.vim/rcplugins/kitty_navigator.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/matchit.vim" "~/.vim/rcplugins/matchit.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/misc.vim" "~/.vim/rcplugins/misc.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/nerdtree.vim" "~/.vim/rcplugins/nerdtree.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/nvim_lsp_config.vim" "~/.vim/rcplugins/nvim_lsp_config.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/polyglot.vim" "~/.vim/rcplugins/polyglot.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/prettier.vim" "~/.vim/rcplugins/prettier.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/regex.vim" "~/.vim/rcplugins/regex.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/scratch.vim" "~/.vim/rcplugins/scratch.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/sessions.vim" "~/.vim/rcplugins/sessions.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/sneak.vim" "~/.vim/rcplugins/sneak.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/surround.vim" "~/.vim/rcplugins/surround.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/syntastic.vim" "~/.vim/rcplugins/syntastic.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/tabularize.vim" "~/.vim/rcplugins/tabularize.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/taglist.vim" "~/.vim/rcplugins/taglist.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/tasks.vim" "~/.vim/rcplugins/tasks.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/tcomment.vim" "~/.vim/rcplugins/tcomment.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/tlib.vim" "~/.vim/rcplugins/tlib.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/unimpaired.vim" "~/.vim/rcplugins/unimpaired.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/vimwiki.vim" "~/.vim/rcplugins/vimwiki.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/xterm_color_table.vim" "~/.vim/rcplugins/xterm_color_table.vim"
handle_file_ln "$PWD/.dotfiles/vim/rcplugins/zettel.vim" "~/.vim/rcplugins/zettel.vim"
handle_file_ln "$PWD/.dotfiles/vim/session.vim" "~/.vim/session.vim"
handle_file_ln "$PWD/.dotfiles/vim/shortcuts.vim" "~/.vim/shortcuts.vim"
handle_file_ln "$PWD/.dotfiles/vim/spell.vim" "~/.vim/spell.vim"
handle_file_ln "$PWD/.dotfiles/vim/tab.vim" "~/.vim/tab.vim"
handle_file_ln "$PWD/.dotfiles/vim/undodir" "~/.vim/undodir"
handle_file_ln "$PWD/.dotfiles/vim/vim-spell-en.utf-8.add" "~/.vim/vim-spell-en.utf-8.add"
handle_file_ln "$PWD/.dotfiles/vim/visual.vim" "~/.vim/visual.vim"
handle_file_ln "$PWD/.dotfiles/zsh/after/find_cam.zsh" "~/.zsh/after/find_cam.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/after/source_env.zsh" "~/.zsh/after/source_env.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/aliases.zsh" "~/.zsh/aliases.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/bat.zsh" "~/.zsh/bat.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/before/brew_completions.zsh" "~/.zsh/before/brew_completions.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/before/oh_my.zsh" "~/.zsh/before/oh_my.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/brew.zsh" "~/.zsh/brew.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/cmatrix.zsh" "~/.zsh/cmatrix.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/command_not_found.zsh" "~/.zsh/command_not_found.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/dip_shortcuts.zsh" "~/.zsh/dip_shortcuts.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/docker.zsh" "~/.zsh/docker.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/dust.zsh" "~/.zsh/dust.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/editor.zsh" "~/.zsh/editor.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/fd.zsh" "~/.zsh/fd.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/functions/bcp" "~/.zsh/functions/bcp"
handle_file_ln "$PWD/.dotfiles/zsh/functions/bip" "~/.zsh/functions/bip"
handle_file_ln "$PWD/.dotfiles/zsh/functions/bup" "~/.zsh/functions/bup"
handle_file_ln "$PWD/.dotfiles/zsh/functions/emoji" "~/.zsh/functions/emoji"
handle_file_ln "$PWD/.dotfiles/zsh/functions/fif" "~/.zsh/functions/fif"
handle_file_ln "$PWD/.dotfiles/zsh/functions/git-churn" "~/.zsh/functions/git-churn"
handle_file_ln "$PWD/.dotfiles/zsh/functions/marked" "~/.zsh/functions/marked"
handle_file_ln "$PWD/.dotfiles/zsh/fzf.zsh" "~/.zsh/fzf.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/gpg.zsh" "~/.zsh/gpg.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/kitty.zsh" "~/.zsh/kitty.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/lsd.zsh" "~/.zsh/lsd.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/nvim.zsh" "~/.zsh/nvim.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/path.zsh" "~/.zsh/path.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/powerlevel10k.zsh" "~/.zsh/powerlevel10k.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/procs.zsh" "~/.zsh/procs.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/rcm.zsh" "~/.zsh/rcm.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/rg.zsh" "~/.zsh/rg.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/rtx.zsh" "~/.zsh/rtx.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/ssh.zsh" "~/.zsh/ssh.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/user.zsh" "~/.zsh/user.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/vim.zsh" "~/.zsh/vim.zsh"
handle_file_ln "$PWD/.dotfiles/zsh/z.zsh" "~/.zsh/z.zsh"
handle_file_ln "$PWD/.dotfiles/zshrc" "~/.zshrc"
