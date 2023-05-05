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

-- which_key mappings
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["lR"] = { ":LspRestart<CR>", "Restart LSP" }

lvim.builtin.which_key.mappings["i"] = {
  name = "Utilities",
  c = {
    name = " Resolve Git Conflicts",
    a = { ":GitConflictListQf<CR>", "Get all conflict to quickfix" },
    b = { ":GitConflictChooseBoth<CR>", "Choose both" },
    j = { ":GitConflictPrevConflict<CR>", "Move to previous conflict" },
    k = { ":GitConflictNextConflict<CR>", "Move to next conflict" },
    n = { ":GitConflictChooseNone<CR>", "Choose none" },
    o = { ":GitConflictChooseOurs<CR>", "Choose ours" },
    t = { ":GitConflictChooseTheirs<CR>", "Choose theirs" },
  },
  e = { ":EslintFixAll<CR>", "Fix eslint errors" },
}

lvim.builtin.which_key.mappings["z"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- search and replace text
lvim.builtin.which_key.mappings["r"] = {
  name = "SearchReplaceSingleBuffer",
  s = { "<CMD>SearchReplaceSingleBufferSelections<CR>", "SearchReplaceSingleBuffer [s]elction list" },
  o = { "<CMD>SearchReplaceSingleBufferOpen<CR>", "[o]pen" },
  w = { "<CMD>SearchReplaceSingleBufferCWord<CR>", "[w]ord" },
  W = { "<CMD>SearchReplaceSingleBufferCWORD<CR>", "[W]ORD" },
  e = { "<CMD>SearchReplaceSingleBufferCExpr<CR>", "[e]xpr" },
  f = { "<CMD>SearchReplaceSingleBufferCFile<CR>", "[f]ile" },

  b = {
    name = "SearchReplaceMultiBuffer",
    s = { "<CMD>SearchReplaceMultiBufferSelections<CR>", "SearchReplaceMultiBuffer [s]elction list" },
    o = { "<CMD>SearchReplaceMultiBufferOpen<CR>", "[o]pen" },
    w = { "<CMD>SearchReplaceMultiBufferCWord<CR>", "[w]ord" },
    W = { "<CMD>SearchReplaceMultiBufferCWORD<CR>", "[W]ORD" },
    e = { "<CMD>SearchReplaceMultiBufferCExpr<CR>", "[e]xpr" },
    f = { "<CMD>SearchReplaceMultiBufferCFile<CR>", "[f]ile" },
  }
}

lvim.keys.visual_block_mode["<C-r>"] = [[<CMD>SearchReplaceSingleBufferVisualSelection<CR>]]
lvim.keys.visual_block_mode["<C-s>"] = [[<CMD>SearchReplaceWithinVisualSelection<CR>]]
lvim.keys.visual_block_mode["<C-b>"] = [[<CMD>SearchReplaceWithinVisualSelectionCWord<CR>]]

vim.o.inccommand = "split"


-- telescope keymaps
lvim.builtin.which_key.mappings["sa"] = {
  function()
    local opts = {
      prompt_title = "Find All Files",
      file_ignore_patterns = { 'node_modules', '.git' },
      hidden = true,
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
