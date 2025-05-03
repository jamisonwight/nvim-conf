-- plugins/init.lua
-- Main plugin specification file for lazy.nvim

return {
  -- Core plugins
  { "nvim-lua/plenary.nvim", lazy = true }, -- Lua functions used by many plugins

  -- Theme configuration moved to plugins/theming.lua
  -- UI Improvements
  {
    "nvim-lualine/lualine.nvim", -- Status line
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto", -- This will automatically adapt to the current colorscheme
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree", "toggleterm" },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim", -- Tab/Buffer line
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "slant",
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },

  -- Editing Improvements
  {
    "windwp/nvim-autopairs", -- Auto close brackets, quotes, etc.
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },

  {
    "numToStr/Comment.nvim", -- Smart commenting
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          -- For JSX/TSX files, use the jsx commenting style
          local U = require("Comment.utils")
          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end
          return require("ts_context_commentstring.internal").calculate_commentstring({
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
          })
        end,
      })
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring", -- Context-aware commenting (for JSX)
    },
  },

  {
    "kylechui/nvim-surround", -- Add/change/delete surroundings
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>fe", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        -- Removed deprecated open_on_setup option
        open_on_tab = true,
        update_focused_file = {
          enable = true,
        },
        view = {
          preserve_window_proportions = true,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$", "node_modules", "dist", ".cache" },
        },
      })
    end,
  },

  -- Fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
      { "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementations" },
      { "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", desc = "Definitions" },
      { "<leader>ft", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Type definitions" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage selected hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset selected hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })
        end,
      })
    end,
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "<C-t>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-t>]],
        shade_filetypes = {},
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 0,
        },
        close_on_exit = true,
      })
    end,
  },

  -- Web development specific
  {
    "norcalli/nvim-colorizer.lua", -- Color highlighting for CSS
    event = "BufRead",
    config = function()
      require("colorizer").setup({
        "css",
        "scss",
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
      })
    end,
  },

  -- Import completion configuration
  { import = "plugins.completion" },

  -- Import treesitter configuration
  { import = "plugins.treesitter" },
}

