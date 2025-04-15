-- plugins/copilot.lua
-- GitHub Copilot Chat configuration

return {
  -- GitHub Copilot Chat (CopilotC-Nvim implementation)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true, -- Re-enabled since Neovim has been upgraded to 0.11.0
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      model = "gpt-4o", -- Default model to use
      show_help = true, -- Show help message when chat window opens
      debug = false, -- Enable debug logging
      mappings = {
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        yank_diff = {
          normal = "gy",
        },
        accept_diff = {
          normal = "<C-y>",
        },
      },
      window = {
        border = "rounded",
        width = 0.8,
        height = 0.7, 
      },
      -- Picker configuration
      picker = {
        -- Uses telescope as the default picker
        -- Available options are: telescope, builtin, dressing, fzf-lua, dressing-select
        active = "telescope", 
        telescope = {
          mappings = {
            -- Insert mode mappings
            ["i"] = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-c>"] = require("telescope.actions").close,
              ["<CR>"] = require("telescope.actions").select_default,
            },
            -- Normal mode mappings
            ["n"] = {
              ["j"] = require("telescope.actions").move_selection_next,
              ["k"] = require("telescope.actions").move_selection_previous,
              ["q"] = require("telescope.actions").close,
              ["<CR>"] = require("telescope.actions").select_default,
            },
          },
        },
      },
      prompts = {
        Explain = {
          prompt = "Explain how the following code works in detail."
        },
        Fix = {
          prompt = "Fix the following code to address any bugs or issues."
        },
        Optimize = {
          prompt = "Optimize the following code for better performance while maintaining readability."
        },
        Tests = {
          prompt = "Generate comprehensive tests for the following code."
        },
        Refactor = {
          prompt = "Refactor the following code to improve clarity and maintainability."
        },
      },
      -- System instructions represent the role of the assistant
      system_instruction = [[
You're an AI programming assistant, providing helpful advice and code snippets.
You answer questions about code and provide suggestions to improve it.
Always be concise and helpful. Prioritize clarity and correctness in your responses.
      ]],
    },
    -- Configuration function
    config = function(_, opts)
      local chat = require("CopilotChat")
      
      -- Add system function for git commands
      _G.system = function(cmd)
        local output = vim.fn.system(cmd)
        return output
      end
      
      chat.setup(opts)
      
      -- Set up commands and keymaps
      vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", { desc = "Copilot Chat" })
      vim.keymap.set("v", "<leader>cc", ":CopilotChatVisual<CR>", { desc = "Copilot Chat Visual" })
      vim.keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Copilot Explain Code" })
      vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "Copilot Fix Code" })
      vim.keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<CR>", { desc = "Copilot Optimize Code" })
      vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Copilot Generate Tests" })
      vim.keymap.set("n", "<leader>cr", "<cmd>CopilotChatRefactor<CR>", { desc = "Copilot Refactor Code" })
      
      -- Additional keymaps for pickers
      vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatModels<CR>", { desc = "Copilot Chat Models" })
      vim.keymap.set("n", "<leader>ca", "<cmd>CopilotChatAgents<CR>", { desc = "Copilot Chat Agents" })
      vim.keymap.set("n", "<leader>cp", "<cmd>CopilotChatPrompts<CR>", { desc = "Copilot Chat Prompts" })
    end,
  },
}
