return {
  "mfussenegger/nvim-lint",
  priority = 450,
  event = {
      "BufReadPre",
      "BufNewFile",
    },
  enabled = true,
  config = function()
    local linter = require('lint')
    linter.linters_by_ft = {
        markdown = {'vale'},
        cpp = {'cpplint'},
--        python = {'mypy', 'ruff'},
    }
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function ()
      linter.try_lint()
    end,
    })
    vim.keymap.set("n", '<leader>ll', function()
      linter.try_lint()
    end)
  end
}
