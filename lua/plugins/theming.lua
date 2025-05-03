-- plugins/theming.lua
-- Theme management with Themery

return {
  -- Themery - Theme switcher
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 900,
    config = function()
      local themes = {
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
          name = "Gentooish",
          colorscheme = "gentooish",
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
        {
          name = "Sweet Fusion",
          colorscheme = "sweetfusion",
        },
      }
      -- Themery configuration
      require("themery").setup({
        themes = themes,
        themeConfigFile = "~/.config/nvim/lua/core/options.lua",
        livePreview = true,
        -- Set default theme (10 for Kanagawa Dragon - after adding new themes)
        defaultTheme = 10,
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

  -- Gentooish
  {
    "cdaddr/gentooish.vim",
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

  -- NEW THEMES SECTION
  -- Hiller - Vibrant dark theme
  {
    "BenoitHiller/hiller.vim",
    name = "hiller",
    lazy = true,
    priority = 1000,
  },
  
  -- Sarnai - Mongolian flower inspired theme
  {
    "titembaatar/sarnai.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = true,
    priority = 1000,
  },
  
  -- Firefly - Dark, comfortable theme
  {
    "christianrickert/vim-firefly",
    name = "firefly",  -- Add this to match colorscheme name
    lazy = true,
    priority = 1000,
  },
  
  -- Neogotham - Gotham colors inspired
  {
    "shmerl/neogotham",
    lazy = true,
    priority = 1000,
  },
  
  -- Neofusion - Dark theme with neon colors
  {
    "diegoulloao/neofusion.nvim",
    lazy = true,
    priority = 1000,
  },
  
  -- Naysayer - Comfortable, muted theme
  {
    "piyush-ppradhan/naysayer.vim",
    lazy = true,
    priority = 1000,
  },
  
  -- Pool - Pool/billiards inspired theme
  {
    "wolandark/pool-vim",
    name = "pool",  -- Add this to match colorscheme name
    lazy = true,
    priority = 1000,
  },
  
  -- Notepad - Windows Notepad inspired theme
  {
    "wolandark/notepad-vim",
    name = "notepad",  -- Add this to match colorscheme name
    lazy = true,
    priority = 1000,
  },
  
  -- Sweet Fusion - Colorful, comfortable theme
  {
    "danieleliasib/sweet-fusion",
    name = "sweetfusion",  -- Update to match actual colorscheme name
    lazy = true,
    priority = 1000,
  },
}

