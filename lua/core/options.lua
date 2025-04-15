-- core/options.lua
-- Neovim options and settings optimized for web development

local opt = vim.opt
local g = vim.g

-- General settings
opt.mouse = "a"                           -- Enable mouse support
opt.clipboard = "unnamedplus"             -- Use system clipboard
opt.swapfile = false                      -- Don't use swapfile
opt.completeopt = "menu,menuone,noselect" -- Completion options for cmp
opt.pumheight = 10                        -- Pop up menu height
opt.showtabline = 2                       -- Always show tabs
opt.splitbelow = true                     -- Split horizontal windows below
opt.splitright = true                     -- Split vertical windows to the right
opt.termguicolors = true                  -- Set term gui colors
opt.timeoutlen = 300                      -- Time to wait for a mapped sequence
opt.undofile = true                       -- Enable persistent undo
opt.updatetime = 100                      -- Faster completion

-- UI settings
opt.number = true                         -- Show line numbers
opt.relativenumber = true                 -- Show relative line numbers
opt.cursorline = true                     -- Highlight current line
opt.signcolumn = "yes"                    -- Always show the sign column
opt.colorcolumn = "80"                    -- Line length marker at 80 columns
opt.laststatus = 3                        -- Global status line
opt.showcmd = false                       -- Hide command in bottom bar
opt.cmdheight = 1                         -- More space in the command line
opt.showmode = false                      -- Don't show mode since we have a statusline
opt.scrolloff = 10                        -- Lines of context
opt.sidescrolloff = 8                     -- Columns of context

-- Text rendering options
opt.encoding = "utf-8"                    -- Use UTF-8 encoding
opt.fileencoding = "utf-8"                -- The encoding written to a file
opt.wrap = false                          -- Display long lines as just one line

-- Tabs and indentation
opt.expandtab = true                      -- Use spaces instead of tabs
opt.shiftwidth = 2                        -- Number of spaces to use for indent
opt.tabstop = 2                           -- Number of spaces tabs count for
opt.softtabstop = 2                       -- Number of spaces that a <Tab> counts for
opt.smartindent = true                    -- Insert indents automatically
opt.breakindent = true                    -- Enable break indent
opt.showbreak = string.rep(" ", 3)        -- Make it so that long lines wrap smartly

-- Search settings
opt.hlsearch = true                       -- Highlight all matches on previous search
opt.ignorecase = true                     -- Ignore case in search patterns
opt.smartcase = true                      -- Override ignorecase if search contains capitals
opt.incsearch = true                      -- Show search matches as you type

-- Folding (useful for React components)
opt.foldmethod = "expr"                   -- Use treesitter for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99                        -- By default, don't fold anything

-- File and directory settings
opt.hidden = true                         -- Enable background buffers
opt.history = 100                         -- Remember N lines in history
opt.writebackup = false                   -- Don't make a backup before overwriting a file
opt.conceallevel = 0                      -- Show text normally
opt.autoread = true                       -- Reload files changed outside vim

-- Web Development specific
opt.path:append("**")                     -- Search down into subfolders
opt.suffixesadd:append({ ".js", ".jsx", ".ts", ".tsx", ".vue", ".css" }) -- Add suffixes for file finding
g.loaded_perl_provider = 0                -- Disable perl provider
g.loaded_ruby_provider = 0                -- Disable ruby provider
g.loaded_node_provider = 0                -- Disable node provider

-- Complete options often used in web dev
opt.wildignore:append({
  "*/node_modules/*",
  "*/dist/*",
  "*/build/*",
  "*.min.js",
  "*.min.css",
})

-- The following line is used by Themery to save the selected theme
-- vim.cmd("colorscheme kanagawa")

return {
  -- This return table will be used by Themery to save the theme configuration
  -- Don't remove this line if you're using Themery
  theme = function()
    vim.cmd("colorscheme kanagawa")
  end
}
