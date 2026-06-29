local map = vim.keymap.set

-- ── 保留 k-vim 的肌肉记忆 ──────────────────────────────────────────
map({ "n", "x" }, "H", "^", { desc = "行首" })
map({ "n", "x" }, "L", "$", { desc = "行尾" })
map("n", "j", "gj", { silent = true }) -- 按可视行移动 (长行换行后更直觉)
map("n", "k", "gk", { silent = true })
map("n", "gj", "j", { silent = true })
map("n", "gk", "k", { silent = true })

-- ── 通用 ───────────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "清搜索高亮" })
map("n", "<leader>w", "<cmd>write<CR>", { desc = "保存" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "关窗口" })

-- buffer 切换 (H/L 已占行首尾, 故用 Tab)
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "下个 buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "上个 buffer" })
-- <leader>bd 关 buffer 交给 mini.bufremove (删 buffer 留窗口布局), 见 plugins/editing.lua

-- 分屏 (跨窗格移动由 vim-tmux-navigator 接管 C-h/j/k/l)
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "竖直分屏" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "水平分屏" })

-- 可视模式: 缩进后保持选中 / 上下移动选中行
map("x", "<", "<gv")
map("x", ">", ">gv")
map("x", "J", ":m '>+1<CR>gv=gv", { desc = "下移选中行" })
map("x", "K", ":m '<-2<CR>gv=gv", { desc = "上移选中行" })

-- 诊断 (LSP 无关, 全局可用)
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "上一个诊断" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "下一个诊断" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "行内诊断浮窗" })
