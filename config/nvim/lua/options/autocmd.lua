-- Markdown folding by headings and indented list children
function _G.MarkdownFoldLevel()
  local line = vim.fn.getline(vim.v.lnum)
  local lnum = vim.v.lnum

  -- Headings start folds at their level
  local heading_match = line:match("^(#+)")
  if heading_match then
    return ">" .. #heading_match
  end

  -- Empty lines keep previous level
  if line:match("^%s*$") then
    return "="
  end

  -- Calculate indent level
  local indent = #(line:match("^(%s*)") or "")
  local sw = vim.bo.shiftwidth or 2
  local base_level = 7 -- Offset to not conflict with h1-h6

  -- Check if next non-empty line is more indented (start a fold)
  local next_lnum = lnum + 1
  local next_line = vim.fn.getline(next_lnum)
  local next_indent = #(next_line:match("^(%s*)") or "")

  if next_indent > indent and not next_line:match("^%s*$") then
    return ">" .. (base_level + math.floor(indent / sw))
  end

  return base_level + math.floor(indent / sw)
end

function _G.MarkdownToggleFold()
  local line = vim.fn.getline(".")
  -- Allow toggle on headings or list items
  if line:match("^#+") or line:match("^%s*[-*+]%s") or line:match("^%s*%d+%.%s") then
    local foldclosed = vim.fn.foldclosed(".")
    if foldclosed == -1 then
      pcall(vim.cmd, "normal! zc")
    else
      vim.cmd("normal! zo")
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.MarkdownFoldLevel()"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
    vim.keymap.set("n", "za", _G.MarkdownToggleFold, { buffer = true, silent = true })
  end,
})

if vim.fn.has("autocmd") == 1 then
  vim.api.nvim_exec([[
    " when we reload, tell vim to restore the cursor to the saved position
    augroup JumpCursorOnEdit
    au!
    autocmd BufReadPost *
    \ if expand(":p:h") !=? $TEMP |
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ let JumpCursorOnEdit_foo = line("'\"") |
    \ let b:doopenfold = 1 |
    \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    \ let b:doopenfold = 2 |
    \ endif |
    \ exe JumpCursorOnEdit_foo |
    \ endif |
    \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \ exe "normal zv" |
    \ if(b:doopenfold > 1) |
    \ exe "+".1 |
    \ endif |
    \ unlet b:doopenfold |
    \ endif
    augroup END

    " Auto deletes git browse buffers when not active (fugitive)
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " hide comments in ruby files 
    " Remove comment on end to auto fold on file load
    " see travisjeffery.com/b/2012/01/automaticallly-fold-comments-in-vim for
    " autocmd FileType ruby,eruby set foldmethod=expr | set foldexpr=getline(v:lnum)=~'^\\s*#'
  ]], false)
end
