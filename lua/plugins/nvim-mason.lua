return {
  {"williamboman/mason.nvim",
    priority = 500,
    config = function ()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {"lua_ls", "clangd", "ruff", "jedi_language_server", "basedpyright" }
      })
    end
  },
  {
    "rshkarin/mason-nvim-lint",
    priority = 400,
    config = function()
      require ('mason-nvim-lint').setup({
       ensure_installed = { 'cpplint', 'mypy', 'ruff', 'pylint' },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    priority = 450,
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require("lspconfig").lua_ls.setup {capabilities = capabilities}
      require("lspconfig").clangd.setup {capabilities = capabilities}
      require("lspconfig").jedi_language_server.setup({
        capabilities = capabilities,
        init_options = {
          completion = {
            disableSnippets = true,
          },
        }
      })
      --[[
      require("lspconfig").ruff.setup({
        capabilities = capabilities,
        init_options = {
          settings = {
            args = {
              "--extend-select=W,COM,ICN",
              "--ignore=E501,E722,COM812",
            },
          },
        },
      })
      ]]--
      require'lspconfig'.basedpyright.setup{}
--      require("lspconfig").pylsp.setup {capabilities=capabilities}
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {noremap = true, silent = true})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  },
  {
    "zapling/mason-conform.nvim",
    priority = 400,
    config = function ()
      require("mason-conform").setup({
          ensure_installed = {'black', 'isort'},
          ignore_install = {'prettier'} -- List of formatters to ignore during install
      })

    end
  }
}
