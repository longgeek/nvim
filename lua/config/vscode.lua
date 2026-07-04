-- 仅在 Cursor / VSCode Neovim (vim.g.vscode) 下加载。
-- leader(空格) 转发到 VSpaceCode whichkey 面板; 菜单项在 settings.json 的 whichkey.bindings。

local map = vim.keymap.set

local function code(cmd)
  return function()
    vim.fn.VSCodeNotify(cmd)
  end
end

-- 空格 → 弹出 whichkey 面板 (菜单里再选 d/f/c 等)
map({ "n", "x" }, "<Space>", code("whichkey.show"), { desc = "whichkey 面板" })

-- 非 leader 的 LSP 跳转 (走 Cursor)
map("n", "gd", code("editor.action.revealDefinition"), { desc = "定义" })
map("n", "gr", code("editor.action.goToReferences"), { desc = "引用" })
map("n", "K", code("editor.action.showHover"), { desc = "悬浮文档" })

-- keymaps.lua 里 normal 模式 <Tab>=bnext 切 buffer; 在 Cursor 下切 nvim buffer
-- 会让 vscode-neovim 把光标同步到旧位置 → "Invalid cursor line: out of range"
-- 卡死 hjkl。设为 <Nop> 彻底禁用: 不崩/不插 tab/不切焦点。
-- 切标签用 Cursor 原生: Cmd+Opt+← / → 。
map("n", "<Tab>", "<Nop>", { desc = "禁用 Tab" })
map("n", "<S-Tab>", "<Nop>", { desc = "禁用 S-Tab" })

-- 折叠: nvim 折叠(treesitter)在 Cursor 里不渲染, 映射到 Cursor 原生折叠。
map("n", "za", code("editor.toggleFold"), { desc = "切换折叠" })
map("n", "zo", code("editor.unfold"), { desc = "展开" })
map("n", "zc", code("editor.fold"), { desc = "折叠" })
map("n", "zR", code("editor.unfoldAll"), { desc = "全部展开" })
map("n", "zM", code("editor.foldAll"), { desc = "全部折叠" })
map("n", "zj", code("editor.gotoNextFold"), { desc = "下一个折叠" })
map("n", "zk", code("editor.gotoPreviousFold"), { desc = "上一个折叠" })

-- j/k 跳过折叠区: keymaps.lua 的 j->gj 是 noremap, 走原生 gj, 进折叠会自动展开。
-- 改调 Cursor 的 cursorDown/Up (在视图空间移动, 天然跳过折叠); count>0 (如 10j)
-- 仍用原生 j/k 保持计数跳行。
map("n", "j", function()
  if vim.v.count == 0 then
    vim.fn.VSCodeNotify("cursorDown")
  else
    return "j"
  end
end, { expr = true, desc = "下移(跳过折叠)" })
map("n", "k", function()
  if vim.v.count == 0 then
    vim.fn.VSCodeNotify("cursorUp")
  else
    return "k"
  end
end, { expr = true, desc = "上移(跳过折叠)" })
