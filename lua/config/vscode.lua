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
