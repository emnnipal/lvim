-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>

-- Commented out because it's not that needed and it consumes a lot of cpu
-- resources in large projects.
lvim.autocommands = {
  {
    "BufWritePre", -- see `:h autocmd-events`
    {
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", },
      command = "EslintFixAll", -- auto fix eslint errors on save
    }
  },
}
