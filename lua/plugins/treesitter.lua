-- plugins/treesitter.lua
-- Treesitter configuration optimized for web development

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",   -- Syntax aware text-objects
      "windwp/nvim-ts-autotag",                       -- Automatically close/rename HTML tags
      "JoosepAlviste/nvim-ts-context-commentstring",  -- Context aware comments for JSX/TSX
    },
    config = function()
      -- Explicitly set the C compiler path for TreeSitter
      -- Explicitly set the C compiler path for TreeSitter
      require("nvim-treesitter.install").compilers = { "/usr/bin/gcc" }
      
      -- Setup context commentstring properly
      vim.g.skip_ts_context_commentstring_module = true
      require('ts_context_commentstring').setup {}
      
      -- Configure Treesitter
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          -- Web development
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "scss",
          "json",
          "jsonc",
          "vue",
          "svelte",
          "graphql",
          "regex",
          
          -- Frameworks and tools
          "jsdoc",
          "yaml",
          "toml",
          "markdown",
          "markdown_inline",
          
          -- Configuration files
          "bash",
          "lua",
          "dockerfile",
          "gitignore",
          "query", -- For writing treesitter queries
        },
        
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        
        -- List of parsers to ignore installing
        ignore_install = {},
        
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          
          -- list of language that will be disabled
          disable = {},
          
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        
        indent = {
          enable = true,
          disable = {},
        },
        
        -- Incremental selection based on the named nodes from the grammar
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
        
        -- Automatically close and rename HTML/JSX tags
        autotag = {
          enable = true,
          filetypes = {
            "html",
            "xml",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "markdown",
          },
        },
        
        
        -- Text objects
        textobjects = {
          select = {
            enable = true,
            
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              -- Using 'v' prefix instead of 'a' to avoid conflicts
              ["vf"] = "@function.outer",
              ["if"] = "@function.inner",
              ["vc"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["vp"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
              ["vl"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["vi"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              ["v/"] = "@comment.outer",
              ["i/"] = "@comment.inner",
              ["vb"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["vs"] = "@statement.outer",
              ["is"] = "@statement.outer",
              ["vj"] = "@jsx_element.outer",
              ["ij"] = "@jsx_element.inner",
            },
          },
          
          -- Jump to the next/previous start or end of functions, classes, etc.
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.outer",
              ["]l"] = "@loop.outer",
              ["]i"] = "@conditional.outer",
              ["]b"] = "@block.outer",
              ["]j"] = "@jsx_element.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.outer",
              ["]L"] = "@loop.outer",
              ["]I"] = "@conditional.outer",
              ["]B"] = "@block.outer",
              ["]J"] = "@jsx_element.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.outer",
              ["[l"] = "@loop.outer",
              ["[i"] = "@conditional.outer",
              ["[b"] = "@block.outer",
              ["[j"] = "@jsx_element.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.outer",
              ["[L"] = "@loop.outer",
              ["[I"] = "@conditional.outer",
              ["[B"] = "@block.outer",
              ["[J"] = "@jsx_element.outer",
            },
          },
          
          -- Can be used to swap parameters
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a]"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>a["] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
}
