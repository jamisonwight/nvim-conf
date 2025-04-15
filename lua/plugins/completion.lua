-- plugins/completion.lua
-- Completion configuration for web development

return {
  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",        -- LSP source
      "hrsh7th/cmp-buffer",          -- Buffer source
      "hrsh7th/cmp-path",            -- Path source
      "hrsh7th/cmp-cmdline",         -- Command line source
      "saadparwaiz1/cmp_luasnip",    -- Snippet source
      "onsails/lspkind.nvim",        -- VS Code-like pictograms
      {
        "L3MON4D3/LuaSnip",          -- Snippet engine
        dependencies = {
          "rafamadriz/friendly-snippets", -- Preconfigured snippets
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()

          -- Add web development snippets
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = {
              vim.fn.stdpath("config") .. "/snippets",
            },
          })
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Helper function to check for words before cursor
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      -- Setup cmp with keybindings and UI
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:CmpNormal",
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:CmpDocNormal",
          }),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
        -- Web development specific sorting
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            function(entry1, entry2)
              local kind1 = entry1:get_kind()
              local kind2 = entry2:get_kind()
              
              -- Web development priorities (function, method, variable)
              local kind_priority = {
                [cmp.lsp.CompletionItemKind.Function] = 0,
                [cmp.lsp.CompletionItemKind.Method] = 0,
                [cmp.lsp.CompletionItemKind.Variable] = 1,
                [cmp.lsp.CompletionItemKind.Field] = 1,
                [cmp.lsp.CompletionItemKind.Property] = 1,
                [cmp.lsp.CompletionItemKind.Constant] = 2,
                [cmp.lsp.CompletionItemKind.Keyword] = 3,
                [cmp.lsp.CompletionItemKind.Class] = 4,
                [cmp.lsp.CompletionItemKind.Interface] = 4,
              }
              
              local priority1 = kind_priority[kind1] or 10
              local priority2 = kind_priority[kind2] or 10
              
              if priority1 ~= priority2 then
                return priority1 < priority2
              end
            end,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      })

      -- Set up command line completions (different for different cmdline types)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Web development specific snippets
      -- Add some custom React and Vue snippets
      luasnip.add_snippets("javascriptreact", {
        luasnip.snippet("rfc", {
          luasnip.text_node("import React from 'react';\n\n"),
          luasnip.text_node("const "),
          luasnip.insert_node(1, "ComponentName"),
          luasnip.text_node(" = () => {\n  return (\n    <div>\n      "),
          luasnip.insert_node(2, ""),
          luasnip.text_node("\n    </div>\n  );\n};\n\nexport default "),
          luasnip.insert_node(3, "ComponentName"),
          luasnip.text_node(";"),
        }),
      })

      luasnip.add_snippets("typescriptreact", {
        luasnip.snippet("rfc", {
          luasnip.text_node("import React from 'react';\n\n"),
          luasnip.text_node("const "),
          luasnip.insert_node(1, "ComponentName"),
          luasnip.text_node(": React.FC = () => {\n  return (\n    <div>\n      "),
          luasnip.insert_node(2, ""),
          luasnip.text_node("\n    </div>\n  );\n};\n\nexport default "),
          luasnip.insert_node(3, "ComponentName"),
          luasnip.text_node(";"),
        }),
      })

      luasnip.add_snippets("vue", {
        luasnip.snippet("vbase", {
          luasnip.text_node("<template>\n  <div>\n    "),
          luasnip.insert_node(1, ""),
          luasnip
            .text_node("\n  </div>\n</template>\n\n<script>\nexport default {\n  name: '"),
          luasnip.insert_node(2, "Component"),
          luasnip.text_node("',\n  data() {\n    return {\n      "),
          luasnip.insert_node(3, ""),
          luasnip
            .text_node("\n    }\n  },\n}\n</script>\n\n<style scoped>\n"),
          luasnip.insert_node(4, ""),
          luasnip.text_node("\n</style>"),
        }),
      })

      -- Setup additional nice web-dev snippets
      luasnip.filetype_extend("javascript", { "jsdoc" })
      luasnip.filetype_extend("typescript", { "tsdoc" })
      luasnip.filetype_extend("javascriptreact", { "jsdoc" })
      luasnip.filetype_extend("typescriptreact", { "tsdoc" })
    end,
  },
}
