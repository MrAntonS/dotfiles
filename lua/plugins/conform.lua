return {
  'stevearc/conform.nvim',
  priority = 450,
  opts = {},
  config = function ()
    require("conform").setup({
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        python = { "black", "isort", "ruff" },
        -- You can customize some of the format options for the filetype (:help conform.format)
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end
}
