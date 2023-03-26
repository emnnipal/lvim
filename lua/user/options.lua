vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
-- vim.opt.mouse = nil

-- general
lvim.log.level = "info"
lvim.format_on_save.enabled = true
-- lvim.format_on_save = { enabled = true, pattern = "*.lua", timeout = 1000 }

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.smartindent = true

-- Color scheme
lvim.colorscheme = "tokyonight-storm"
-- lvim.colorscheme = "monokai-pro"
-- lvim.colorscheme = "everforest"

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
