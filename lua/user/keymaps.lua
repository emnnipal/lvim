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
lvim.builtin.which_key.mappings["."] = {
  name = "Utilities",
  e = {
    -- to run a cli command in the background use :!cmd
    -- ":!npm run env -- eslint --fix --cache %<CR><CR>",
    ":EslintFixAll<CR>",
    "Fix eslint errors",
  },
  c = {
    name = " Resolve Git Conflicts",
    o = {
      ":GitConflictChooseOurs<CR>",
      "Choose ours"
    },
    t = {
      ":GitConflictChooseTheirs<CR>",
      "Choose theirs"
    },
    b = {
      ":GitConflictChooseBoth<CR>",
      "Choose both"
    },
    n = {
      ":GitConflictChooseNone<CR>",
      "Choose none"
    },
    j = {
      ":GitConflictPrevConflict<CR>",
      "Move to previous conflict"
    },
    k = {
      ":GitConflictNextConflict<CR>",
      "Move to next conflict"
    },
    a = {
      ":GitConflictListQf<CR>",
      "Get all conflict to quickfix"
    },
  }
}
lvim.builtin.which_key.mappings["z"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.which_key.mappings["s/"] = {
  function()
    require('telescope.builtin').current_buffer_fuzzy_find(
      require('telescope.themes').get_dropdown {
        winblend = 0, -- window opacity
        previewer = true,
      }
    )
  end,
  "Fuzzy search in current buffer"
}


-- LSP dependent keymaps
lvim.lsp.buffer_mappings.normal_mode["gh"] = {
  vim.lsp.buf.hover, "Display hover info"
}
-- unmap keymap "K" from lunarvim
lvim.lsp.buffer_mappings.normal_mode["K"] = nil
lvim.lsp.buffer_mappings.normal_mode["<leader>m"] = { ":TSJToggle<CR>", "Toggle split/join" }
lvim.lsp.buffer_mappings.normal_mode["gr"] = {
  function()
    require('telescope.builtin').lsp_references(
      require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = true,
      }
    )
  end,
  "Goto references"
}
lvim.lsp.buffer_mappings.normal_mode["gd"] = {
  function()
    require('telescope.builtin').lsp_definitions()
  end,
  "Goto definition"
}
