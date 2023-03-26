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