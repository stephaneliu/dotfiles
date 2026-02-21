-- Pre-commit hook script for automatic ctags regeneration
-- Used by :CtagsInstallHook command (task 4.1.1)
local HOOK_SCRIPT = [[#!/bin/sh
# Regenerate ctags on commit
# Runs in background to avoid blocking commits
ctags -R -f .tags --options=$HOME/.ctags.d/project.ctags 2>/dev/null &
exit 0
]]

return {
  "ctags-config",
  lazy = false,
  config = function()
    -- Look for .tags in current directory and parents, fallback to home directory
    vim.opt.tags = "./.tags;,~/.tags"

    -- Get git root directory or fall back to cwd
    local function get_project_root()
      local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
      if vim.v.shell_error == 0 and git_root ~= "" then
        return git_root
      end
      return vim.fn.getcwd()
    end

    -- Regenerate ctags for the current project
    vim.api.nvim_create_user_command("CtagsRegen", function()
      local root = get_project_root()
      local tags_file = root .. "/.tags"
      local ctags_config = vim.fn.expand("~/.ctags.d/project.ctags")

      local cmd = { "ctags", "-R", "-f", tags_file, "--options=" .. ctags_config, root }

      vim.fn.jobstart(cmd, {
        on_exit = function(_, exit_code)
          vim.schedule(function()
            if exit_code == 0 then
              vim.notify("Tags regenerated: " .. tags_file, vim.log.levels.INFO)
            else
              vim.notify("Failed to regenerate tags (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
            end
          end)
        end,
        on_stderr = function(_, data)
          if data and data[1] ~= "" then
            vim.schedule(function()
              vim.notify("ctags error: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
            end)
          end
        end,
      })

      vim.notify("Regenerating tags...", vim.log.levels.INFO)
    end, { desc = "Regenerate ctags for current project" })

    -- Install pre-commit hook for automatic tag regeneration
    vim.api.nvim_create_user_command("CtagsInstallHook", function()
      local root = get_project_root()
      local hook_path = root .. "/.git/hooks/pre-commit"

      -- Check if .git/hooks directory exists
      local hooks_dir = root .. "/.git/hooks"
      if vim.fn.isdirectory(hooks_dir) == 0 then
        vim.notify("Not a git repository or .git/hooks not found", vim.log.levels.ERROR)
        return
      end

      -- Check if hook already exists
      if vim.fn.filereadable(hook_path) == 1 then
        vim.notify("Pre-commit hook already exists: " .. hook_path, vim.log.levels.WARN)
        return
      end

      -- Write hook script
      local file = io.open(hook_path, "w")
      if not file then
        vim.notify("Failed to create hook file: " .. hook_path, vim.log.levels.ERROR)
        return
      end
      file:write(HOOK_SCRIPT)
      file:close()

      -- Make hook executable
      vim.fn.system({ "chmod", "+x", hook_path })
      if vim.v.shell_error ~= 0 then
        vim.notify("Failed to make hook executable", vim.log.levels.ERROR)
        return
      end

      vim.notify("Installed pre-commit hook: " .. hook_path, vim.log.levels.INFO)
    end, { desc = "Install git pre-commit hook for ctags regeneration" })
  end,
}