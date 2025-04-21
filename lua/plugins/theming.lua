-- plugins/theming.lua
-- Theme management with Themery

return {
  -- Themery - Theme switcher
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 900,
    config = function()
      {
        name = "Hiller",
        colorscheme = "hiller",
      },
      {
        name = "Sarnai",
        colorscheme = "sarnai",
      },
      {
        name = "Firefly",
        colorscheme = "firefly",
      },
      {
        name = "Neogotham",
        colorscheme = "neogotham",
      },
      {
        name = "Neofusion",
        colorscheme = "neofusion",
      },
      {
        name = "Naysayer",
        colorscheme = "naysayer",
      },
      {
        name = "Pool",
        colorscheme = "pool",
      },
      {
        name = "Notepad",
        colorscheme = "notepad",
      },
      {
        name = "Sweet Fusion",
        colorscheme = "sweet-fusion",
      },
        {
          name = "Kanagawa Dragon",
          colorscheme = "kanagawa",
          before = [[
            vim.g.kanagawa_variant = "dragon"
          ]],
        },
        {
          name = "Kanagawa Wave",
          colorscheme = "kanagawa",
          before = [[
            vim.g.kanagawa_variant = "wave"
          ]],
        },
        {
          name = "Kanagawa Lotus",
          colorscheme = "kanagawa",
          before = [[
            vim.g.kanagawa_variant = "lotus"
          ]],
        },
        {
          name = "Nord",
          colorscheme = "nord",
        },
        {
          name = "Vesper",
          colorscheme = "vesper",
        },
        {
          name = "Everforest",
          colorscheme = "everforest",
          before = [[
            vim.g.everforest_background = "hard"
          ]],
        },
        {
          name = "Moonfly",
          colorscheme = "moonfly",
        },
        {
          name = "Bamboo",
          colorscheme = "bamboo",
        },
        {
          name = "Melange",
          colorscheme = "melange",
        },
        {
          name = "Zenbones",
          colorscheme = "zenbones",
        },
        {
          name = "Eldritch",
          colorscheme = "eldritch",
        },
        {
          name = "OceanicNext",
          colorscheme = "OceanicNext",
        },
        {
          name = "Modus Vivendi",
          colorscheme = "modus-vivendi",
        },
        {
          name = "Modus Operandi",
          colorscheme = "modus-operandi",
        },
        {
          name = "Mellifluous",
          colorscheme = "mellifluous",
        },
        {
          name = "Miasma",
          colorscheme = "miasma",
        },
        {
          name = "Oldworld",
          colorscheme = "onedark",
        },
        {
          name = "Arctic",
          colorscheme = "arctic",
        },
        {
          name = "Boo",
          colorscheme = "boo",
        },
        {
          name = "Darkvoid",
          colorscheme = "icy",
        },
      }

      -- Themery configuration
      require("themery").setup({
        themes = themes,
        themeConfigFile = "~/.config/nvim/lua/core/options.lua",
        livePreview = true,
        -- Set default theme (1 for Kanagawa Dragon)
        defaultTheme = 1,
      })

      -- Set up keymaps
      vim.keymap.set("n", "<leader>th", "<cmd>Themery<CR>", { desc = "Themery - Switch Theme" })
    end,
  },

  -- Themes

  -- Kanagawa (already in plugins/init.lua, but moved here for consistency)
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
  },

  -- Nord
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },

  -- Vesper
  {
    "datsfilipe/vesper.nvim",
    lazy = true,
  },

  -- Everforest
  {
    "sainnhe/everforest",
    lazy = true,
  },

  -- Moonfly
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
  },

  -- Bamboo
  {
    "ribru17/bamboo.nvim",
    lazy = true,
  },

  -- Melange
  {
    "savq/melange-nvim",
    lazy = true,
  },

  -- Zenbones
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = true,
  },

  -- Eldritch
  {
    "eldritch-theme/eldritch.nvim",
    lazy = true,
  },

  -- OceanicNext
  {
    "mhartington/oceanic-next",
    lazy = true,
  },

  -- Modus Themes
  {
    "miikanissi/modus-themes.nvim",
    lazy = true,
  },

  -- Mellifluous
  {
    "ramojus/mellifluous.nvim",
    lazy = true,
  },

  -- Miasma
  {
    "xero/miasma.nvim",
    lazy = true,
  },

  -- Oldworld
  {
    "ful1e5/onedark.nvim",
    name = "oldworld",
    lazy = true,
  },

  -- Arctic
  {
    "rockyzhang24/arctic.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = true,
  },

  -- Boo
  {
    "rockerBOO/boo-colorscheme-nvim",
    lazy = true,
  },

  -- Darkvoid
  {
    "elianiva/icy.nvim",
    name = "darkvoid",
    lazy = true,
  },
}

