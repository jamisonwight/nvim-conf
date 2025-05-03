-- plugins/copilot.lua
-- GitHub Copilot Chat configuration

return {
  -- Markdown rendering for Copilot Chat
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      file_types = { "markdown", "copilot-chat" },
    },
    ft = { "markdown", "copilot-chat" },
  },
  -- GitHub Copilot Chat (CopilotC-Nvim implementation)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true, -- Re-enabled since Neovim has been upgraded to 0.11.0
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
      model = "gpt-4", -- Default model to use
      show_help = true, -- Show help message when chat window opens
      debug = false, -- Enable debug logging
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      highlight_headers = true, -- Enable header highlighting for markdown rendering
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
        width = 0.5,      -- Use 50% of screen width for vertical split
        height = 0.9,     -- Use 90% of screen height
        layout = "vertical", -- Use vertical split layout
      },
      icons = {
        comments = "",
        user = "",
        assistant = "",
        system = "漣",
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
      
      -- Buffer-specific settings for Copilot Chat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
          
          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
      
      -- Custom command for vertical split chat
      vim.api.nvim_create_user_command("CopilotChatToggle", function()
        -- Get the current buffer
        local buf = vim.api.nvim_get_current_buf()
        
        -- Check if there's already a chat window open
        local chat_win = nil
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "copilot-chat" or vim.api.nvim_buf_get_name(buf):match("^copilot%-chat") then
            chat_win = win
            break
          end
        end
        
        if chat_win then
          -- Close the chat window if it exists
          vim.api.nvim_win_close(chat_win, true)
        else
          -- Use the toggle function if available, otherwise fallback to command
          local ok, result = pcall(function()
            return require("CopilotChat").toggle ~= nil
          end)
          
          if ok and result then
            require("CopilotChat").toggle()
          else
            vim.cmd("CopilotChat")
          end
        end
      end, {})
      
      -- Set up commands and keymaps
      vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Copilot Chat Toggle" })
      vim.keymap.set("v", "<leader>cc", ":CopilotChatVisual<CR>", { desc = "Copilot Chat Visual" })
      vim.keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Copilot Explain Code" })
      vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "Copilot Fix Code" })
      vim.keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<CR>", { desc = "Copilot Optimize Code" })
      vim.keymap.set("n", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Copilot Generate Tests" })
      vim.keymap.set("n", "<leader>cr", "<cmd>CopilotChatRefactor<CR>", { desc = "Copilot Refactor Code" })
      vim.keymap.set("n", "<leader>cg", "<cmd>CopilotChatCommitMessage<CR>", { desc = "Copilot Generate Commit Message" })
      
      -- Additional keymaps for pickers
      vim.keymap.set("n", "<leader>cm", "<cmd>CopilotChatModels<CR>", { desc = "Copilot Chat Models" })
      vim.keymap.set("n", "<leader>ca", "<cmd>CopilotChatAgents<CR>", { desc = "Copilot Chat Agents" })
      vim.keymap.set("n", "<leader>cp", "<cmd>CopilotChatPrompts<CR>", { desc = "Copilot Chat Prompts" })
    end,
  },
}
