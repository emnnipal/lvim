-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

-- As much as possible, use alt + key or leader + key instead of cmd + key
-- since cmd key isn't widely supported to be used as a modifier key.

-- Override the default save keymap in buffer_mappings so that BuffWritePre
-- won't be triggered on every file update.
lvim.lsp.buffer_mappings.normal_mode["<leader>w"] = { ":update<CR>", "Save" }
lvim.keys.normal_mode["<D-s>"] = ":update<CR>"
-- this doesn't work
-- lvim.keys.insert_mode["<D-s>"] = ":update<CR>"

lvim.keys.normal_mode["<leader>k"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<leader>j"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<D-k>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<D-j>"] = ":BufferLineCyclePrev<CR>"

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
lvim.builtin.which_key.mappings["lR"] = { ":LspRestart<CR>", "Restart LSP" }
lvim.builtin.which_key.mappings["i"] = {
  name = "Utilities",
  e = {
    -- to run a cli command use :!cmd
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
lvim.builtin.which_key.mappings["sa"] = {
  function()
    local opts = {
      prompt_title = "Find All Files",
      file_ignore_patterns = { 'node_modules', '.git' },
      hidden = true,
      follow = true,
      no_ignore = true,
    }
    require("telescope.builtin").find_files(opts)
  end,
  "Find All Files" }
lvim.builtin.which_key.mappings["sr"] = {
  function()
    local opts = {
      cwd_only = true
    }
    require("telescope.builtin").oldfiles(opts)
  end, "Open Recent File" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" }
lvim.builtin.which_key.mappings["s/"] = {
  "<cmd>Telescope current_buffer_fuzzy_find<cr>",
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
