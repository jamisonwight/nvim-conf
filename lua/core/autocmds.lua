-- core/autocmds.lua
-- Autocommands for Neovim with web development focus

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General Settings
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = general,
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = general,
  command = "checktime",
})

-- Web Development specific
local web_dev = augroup("WebDevelopment", { clear = true })

-- Set indentation for specific web files
autocmd("FileType", {
  group = web_dev,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "html", "css", "scss", "vue" },
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})

-- Treat these files as their correct types
autocmd({ "BufRead", "BufNewFile" }, {
  group = web_dev,
  pattern = "*.jsx",
  command = "set filetype=javascriptreact",
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = web_dev,
  pattern = "*.tsx",
  command = "set filetype=typescriptreact",
})

-- Recognize common config files
autocmd({ "BufRead", "BufNewFile" }, {
  group = web_dev,
  pattern = { ".babelrc", ".eslintrc", "tsconfig.json", "jsconfig.json", ".prettierrc" },
  command = "set filetype=json",
})

-- Auto-formatting (to be enhanced by LSP config)
autocmd("FileType", {
  group = web_dev,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "scss", "html", "json" },
  callback = function()
    -- Placeholder for format on save with LSP
    -- Will be enhanced once LSP is configured
    vim.opt_local.formatoptions:append({ "r" })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = web_dev,
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.html", "*.css", "*.json", "*.vue" },
  command = [[%s/\s\+$//e]],
})

-- Terminal settings
local terminal = augroup("Terminal", { clear = true })

-- Auto enter insert mode when switching to a terminal
autocmd("TermOpen", {
  group = terminal,
  command = "setlocal nonumber norelativenumber signcolumn=no",
})

autocmd("TermOpen", {
  group = terminal,
  command = "startinsert",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  group = terminal,
  pattern = "term://*",
  command = "stopinsert",
})

return {}

