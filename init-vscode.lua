-- Cursor / VSCode Neovim 专用配置 (不加载 lazy 插件)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 8
opt.wrap = false
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

local map = vim.keymap.set

-- 保留 k-vim 肌肉记忆
map({ "n", "x" }, "H", "^", { desc = "行首" })
map({ "n", "x" }, "L", "$", { desc = "行尾" })
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "清搜索高亮" })
map("n", "<leader>w", function() vim.fn.VSCodeNotify("workbench.action.files.save") end, { desc = "保存" })
map("n", "<leader>q", function() vim.fn.VSCodeNotify("workbench.action.closeActiveEditor") end, { desc = "关窗口" })

-- 调试: 对齐 dap.lua, 走 Cursor 原生调试
map("n", "<leader>db", function() vim.fn.VSCodeNotify("editor.debug.action.toggleBreakpoint") end, { desc = "断点" })
map("n", "<leader>dc", function()
  vim.fn.VSCodeNotify("workbench.action.debug.start")
  vim.fn.VSCodeNotify("workbench.action.debug.continue")
end, { desc = "启动/继续" })
map("n", "<leader>do", function() vim.fn.VSCodeNotify("workbench.action.debug.stepOver") end, { desc = "step over" })
map("n", "<leader>di", function() vim.fn.VSCodeNotify("workbench.action.debug.stepInto") end, { desc = "step into" })
map("n", "<leader>dO", function() vim.fn.VSCodeNotify("workbench.action.debug.stepOut") end, { desc = "step out" })
map("n", "<leader>dt", function() vim.fn.VSCodeNotify("workbench.action.debug.stop") end, { desc = "终止" })
map("n", "<leader>du", function() vim.fn.VSCodeNotify("workbench.view.debug") end, { desc = "Debug 面板" })

-- insert 模式 jk 退 normal
map("i", "jk", "<Esc>", { desc = "退 Normal" })
