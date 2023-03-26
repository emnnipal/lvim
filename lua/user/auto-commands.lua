-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
lvim.autocommands = {
  {
    "BufWritePre", -- see `:h autocmd-events`
    {
      -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", }, -- see `:h autocmd-events`
      command = "EslintFixAll",
    }
  },
}
