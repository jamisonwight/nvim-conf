return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    sort_by = "case_sensitive",
    view = {
      width = 40,
      signcolumn = "yes",
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
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
    filters = {
      dotfiles = false,
      custom = { "^.git$", "node_modules", "dist", ".cache" },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
    },
    git = {
      enable = true,
      ignore = false,
    },
    modified = {
      enable = true,
    },
    confirm = {
      remove = true,
      trash = true,
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
  end,
}
