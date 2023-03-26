--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = nil

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

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

-- as much as possible, use alt + key or leader + key instead of cmd + key
-- since cmd key isn't widely supported to be used as a modifier key

-- cmd key not working in alacritty and kitty so we use leader key instead
lvim.keys.normal_mode["<leader>w"] = ":update<CR>"
lvim.keys.normal_mode["<D-s>"] = ":update<CR>"
-- this doesn't work
-- lvim.keys.insert_mode["<D-s>"] = ":update<CR>"

lvim.keys.normal_mode["<leader>k"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<leader>j"] = ":BufferLineCyclePrev<CR>"

-- vim multi select custom keymaps
lvim.keys.normal_mode["<A-k>"] = '<Plug>(VM-Add-Cursor-Up)'
lvim.keys.normal_mode["<A-j>"] = '<Plug>(VM-Add-Cursor-Down)'

-- select all text with ctrl + a
-- vim.keymap.set({ '', 'i' }, '<C-a>', '<Esc>ggVG')
vim.keymap.set({ '', 'n' }, '<D-a>', '<Esc>ggVG')

-- apply escape shortcuts in insert mode and command mode
vim.keymap.set({ 'i', 'c' }, 'jk', '<Esc>')
vim.keymap.set({ 'i', 'c' }, 'kj', '<Esc>')

-- apply highlighting shortcuts in all modes and visual mode
vim.keymap.set({ '', 'v' }, 'J', '10j')
vim.keymap.set({ '', 'v' }, 'K', '10k')
vim.keymap.set({ '', 'v' }, 'H', '^')
vim.keymap.set({ '', 'v' }, 'L', '$')

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["u"] = {
  name = "Utilities",
  e = {
    -- to run a cli command in the background use :!cmd
    -- ":!npm run env -- eslint --fix --cache %<CR><CR>",
    ":EslintFixAll<CR>",
    "Fix eslint errors",
  },
}
lvim.builtin.which_key.mappings["z"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- LSP dependent keymaps
lvim.lsp.buffer_mappings.normal_mode["gh"] = {
  vim.lsp.buf.hover, "Display hover info"
}
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["<leader>m"] = { ":TSJToggle<CR>", "Toggle split/join" }

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("eslint")

-- Tailwind CSS color highlighting
local nvim_lsp = require("lspconfig")
nvim_lsp["tailwindcss"].setup({
  on_attach = function(client, bufnr)
    require("tailwindcss-colors").buf_attach(bufnr)
  end
  ,
})

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
  },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>

lvim.plugins = {
  {
    'akinsho/git-conflict.nvim',
    event = "BufReadPre",
    opts = {}
  },
  {
    'github/copilot.vim',
    event = "BufReadPre",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      local cmp = require "cmp"
      lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          local copilot_keys = vim.fn["copilot#Accept"]()
          if copilot_keys ~= "" then
            vim.api.nvim_feedkeys(copilot_keys, "i", true)
          else
            fallback()
          end
        end
      end
    end,
  },
  {
    'mg979/vim-visual-multi',
    event = "BufReadPre",
  },
  {
    'kylechui/nvim-surround',
    event = "BufReadPre",
    opts = {}
  },
  {
    'loctvl842/monokai-pro.nvim',
    lazy = lvim.colorscheme ~= "monokai-pro", -- load on colorscheme change
    opts = {
      filter = "machine"
    }
  },
  {
    'neanias/everforest-nvim',
    lazy = lvim.colorscheme ~= "everforest",
    config = function()
      require("everforest").setup({
        background = "medium", -- "soft", "medium", "hard", default is "medium"
      })
    end
  },
  {
    'phaazon/hop.nvim',
    event = "BufReadPre",
    config = function()
      local hop = require('hop')
      hop.setup()
      vim.keymap.set('', 'm', function()
        hop.hint_words()
      end, { remap = true })
    end
  },
  {
    'Wansmer/treesj',
    event = "BufReadPre",
    requires = { 'nvim-treesitter' },
    opts = {
      use_default_keymaps = false
    }
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd("highlight default link gitblame SpecialComment")
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_when_not_committed = ''
      vim.g.gitblame_message_template = '  <author>, <date> • <sha> • <summary>'
      vim.g.gitblame_date_format = '%r'
    end,
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    -- load only on require("tailwindcss-colors")
    module = "tailwindcss-colors",
    opts = {}
  }
}

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
