-- core/keymaps.lua
-- Key mappings focused on web development workflow

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap space as leader key (already set in init.lua but here for clarity)
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- Using <cmd> instead of : for more reliable command execution
-- These commands allow you to move through open buffers:
-- Shift+L - Go to next buffer
-- Shift+H - Go to previous buffer
-- Alt+L - Another option for next buffer
-- Alt+H - Another option for previous buffer
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)
keymap("n", "<A-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<A-h>", "<cmd>bprevious<CR>", opts)

-- Close buffer
keymap("n", "<leader>c", ":bd<CR>", opts)
keymap("n", "<leader>C", ":bd!<CR>", opts)

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Stay in visual mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Clear search highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)

-- Quit
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":qa!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Copy to system clipboard
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+yg_', opts)
keymap("n", "<leader>y", '"+y', opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Split window
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)

-- Web development specific keymaps
-- (More will be added with LSP and plugin configurations)

-- Toggle fold
keymap("n", "<leader>z", "za", opts)

-- Navigate between HTML/JSX tags (to be enhanced by tree-sitter later)
keymap("n", "<leader>nt", "vat", opts) -- Select tag
keymap("n", "<leader>pt", "vit", opts) -- Select inside tag

-- Move to start/end of line (useful for editing long JSX lines)
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Quick snippets with Lua (placeholders for actual snippet plugin)
keymap("n", "<leader>rf", "iimport React from 'react';<CR><CR>function Component() {<CR>  return (<CR>    <div><CR>      <CR>    </div><CR>  );<CR>}<CR><CR>export default Component;<Esc>?Component<CR>cw", { noremap = true })
keymap("n", "<leader>rc", "iimport React, { useState } from 'react';<CR><CR>function Component() {<CR>  const [state, setState] = useState();<CR><CR>  return (<CR>    <div><CR>      <CR>    </div><CR>  );<CR>}<CR><CR>export default Component;<Esc>?Component<CR>cw", { noremap = true })

return {}

