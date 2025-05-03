-- Telescope configuration
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make",
        enabled = vim.fn.executable("make") == 1 
      },
      "nvim-tree/nvim-web-devicons",
      "tsakirist/telescope-lazy.nvim", -- Add telescope-lazy for plugin management
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      telescope.setup({
        defaults = {
          prompt_prefix = "❯ ",
          selection_caret = "❯ ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-c>"] = actions.close,
              ["<C-u>"] = false, -- Clear prompt with C-u
              ["<C-w>"] = function()
                vim.api.nvim_input("<c-s-w>")
              end,
            },
            n = {
              ["<esc>"] = actions.close,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
        },
        extensions = {
          lazy = {
            -- Optional theme configuration
            theme = "ivy",
            -- Optional mappings for lazy window
            mappings = {
              open_in_browser = "<C-o>",
              open_in_file_browser = "<M-b>",
              open_in_find_files = "<C-f>",
              open_in_live_grep = "<C-g>",
              open_plugins_picker = "<C-p>", -- Opens a picker to jump to plugins files
              open_lazy_root_find_files = "<C-r>f", -- Opens telescope find_files at lazy root
              open_lazy_root_live_grep = "<C-r>g", -- Opens telescope live_grep at lazy root
            },
          },
        },
      })
      
      -- Load extensions
      telescope.load_extension("fzf")
      telescope.load_extension("lazy")
      
      -- Keymaps for Telescope and plugin management
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
      
      -- Plugin management keymaps
      vim.keymap.set("n", "<leader>fp", "<cmd>Telescope lazy<cr>", { desc = "Plugins (Lazy)" })
      vim.keymap.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Colorschemes" })
    end,
  },
}
