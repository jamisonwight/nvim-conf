-- plugins/lsp.lua
-- LSP configuration for web development

return {
  -- Mason for managing LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  
  -- Mason-lspconfig for easy LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "tsserver",         -- TypeScript/JavaScript
          "html",             -- HTML
          "cssls",            -- CSS
          "tailwindcss",      -- Tailwind CSS
          "emmet_ls",         -- Emmet
          "lua_ls",           -- Lua
          "jsonls",           -- JSON
          "eslint",           -- ESLint
          "volar",            -- Vue
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",         -- LSP source for nvim-cmp
      "folke/neodev.nvim",            -- Better Lua development
    },
    config = function()
      -- Setup neodev for better Lua development
      require("neodev").setup()
      
      -- LSP settings
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- Global mappings
      -- See `:help vim.diagnostic.*` for documentation
      vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Open float" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Set location list" })

      -- Custom on_attach function
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Buffer local mappings
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
        vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add workspace folder" })
        vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "Remove workspace folder" })
        vim.keymap.set("n", "<leader>lwl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = bufnr, desc = "List workspace folders" })
        vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
        vim.keymap.set("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, { buffer = bufnr, desc = "Format" })

        -- Auto-format on save for specific filetypes
        if client.supports_method("textDocument/formatting") then
          local web_filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
          }
          
          local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
          for _, ft in ipairs(web_filetypes) do
            if ft == filetype then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
              break
            end
          end
        end
      end

      -- Configure specific LSP servers for web development

      -- TypeScript/JavaScript
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Disable formatting from tsserver since we'll use null-ls or prettier
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          html = {
            format = {
              indentInnerHtml = true,
              wrapLineLength = 120,
              wrapAttributes = "auto",
            },
          },
        },
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      })

      -- ESLint
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Custom commands for ESLint
          vim.api.nvim_create_user_command("EslintFixAll", function()
            vim.cmd("EslintFixAll")
          end, {})
          -- Format on save with ESLint if applicable
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        settings = {
          packageManager = "npm",
          workingDirectory = { mode = "auto" },
          useESLintClass = false,
          experimental = {
            useFlatConfig = false,
          },
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine",
            },
            showDocumentation = {
              enable = true,
            },
          },
        },
      })

      -- Tailwind CSS
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            validate = true,
            emmetCompletions = true,
            colorDecorators = true,
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidConfigPath = "error",
              invalidTailwindDirective = "error",
            },
          },
        },
      })

      -- Emmet
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "html",
          "typescriptreact",
          "javascriptreact",
          "css",
          "sass",
          "scss",
          "less",
          "vue",
        },
      })

      -- JSON
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- Vue
      lspconfig.volar.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "vue" },
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Mason-lspconfig automatic setup
      require("mason-lspconfig").setup_handlers({
        -- Default handler
        function(server_name)
          -- Skip servers that are manually configured above
          local manually_configured = {
            "tsserver",
            "html",
            "cssls",
            "eslint",
            "tailwindcss",
            "emmet_ls",
            "jsonls",
            "volar",
            "lua_ls",
          }
          
          for _, name in ipairs(manually_configured) do
            if server_name == name then
              return
            end
          end
          
          -- Otherwise, set up with default options
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
      })
    end,
  },

  -- JSON Schemas
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Null-ls for formatting and linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      
      null_ls.setup({
        debug = false,
        sources = {
          -- Formatting
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript",
              "typescript",
              "javascriptreact",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "jsonc",
              "yaml",
              "markdown",
              "graphql",
            },
          }),
          null_ls.builtins.formatting.stylua,
          
          -- Diagnostics
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.stylelint.with({
            filetypes = { "scss", "css", "sass", "less" },
          }),
          
          -- Code actions
          null_ls.builtins.code_actions.eslint_d,
        },
        on_attach = function(client, bufnr)
          -- Format on save
          if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  filter = function(client)
                    -- Use null-ls for formatting
                    return client.name == "null-ls"
                  end,
                })
              end,
              desc = "Format on save",
            })
          end
        end,
      })
    end,
  },
}

