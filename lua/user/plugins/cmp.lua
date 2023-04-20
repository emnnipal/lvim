-- allow duplicates in the completion menu
lvim.builtin.cmp.formatting.duplicates.nvim_lsp = 1
lvim.builtin.cmp.formatting.duplicates_default = 1
lvim.builtin.cmp.formatting.max_width = 36

-- customize the completion menu
lvim.builtin.cmp.formatting.format = function(entry, vim_item)
  local max_width = lvim.builtin.cmp.formatting.max_width
  local max_detail_width = 20
  local kind = vim_item.kind

  if max_width ~= 0 and #vim_item.abbr > max_width then
    vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. lvim.icons.ui.Ellipsis
  end
  if lvim.use_icons then
    vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[kind]

    if entry.source.name == "copilot" then
      vim_item.kind = lvim.icons.git.Octoface
      vim_item.kind_hl_group = "CmpItemKindCopilot"
    end

    if entry.source.name == "cmp_tabnine" then
      vim_item.kind = lvim.icons.misc.Robot
      vim_item.kind_hl_group = "CmpItemKindTabnine"
    end

    if entry.source.name == "crates" then
      vim_item.kind = lvim.icons.misc.Package
      vim_item.kind_hl_group = "CmpItemKindCrate"
    end

    if entry.source.name == "lab.quick_data" then
      vim_item.kind = lvim.icons.misc.CircuitBoard
      vim_item.kind_hl_group = "CmpItemKindConstant"
    end

    if entry.source.name == "emoji" then
      vim_item.kind = lvim.icons.misc.Smiley
      vim_item.kind_hl_group = "CmpItemKindEmoji"
    end
  end
  local source_name = lvim.builtin.cmp.formatting.source_names[entry.source.name]
  local detail = string.sub(entry.completion_item.detail or "", 1, max_detail_width)

  -- vim_item.menu = string.format("(%s) %s", kind, detail)
  vim_item.menu = string.format("%s %s", source_name, detail)
  vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
      or lvim.builtin.cmp.formatting.duplicates_default

  return vim_item
end
