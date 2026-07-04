local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.termguicolors = true                -- 真彩色 (Ghostty/tmux 已 RGB)
opt.clipboard = "unnamedplus"           -- 系统剪贴板 (配合 tmux pbcopy)
opt.undofile = true                     -- 持久 undo
opt.ignorecase = true
opt.smartcase = true                    -- 含大写时区分大小写
opt.signcolumn = "yes"                  -- 常驻符号列, 避免抖动
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.updatetime = 200                    -- 更快的 CursorHold / git 标记
opt.timeoutlen = 400                    -- which-key 弹出节奏
opt.cursorline = true
opt.wrap = false
opt.expandtab = true                    -- 默认 2 空格 (Python 在 ftplugin 改 4)
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true                      -- 退出未保存时提示而非报错
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.winminwidth = 5

-- 代码折叠: treesitter 按语法节点折 (函数/块); 默认全展开 (foldlevel 高), 手动 za/zc 折
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"  -- 核心 API, 不依赖 nvim-treesitter 分支
opt.foldtext = ""                       -- 空 = 折叠首行显示原文并带语法高亮 (0.10+)
opt.foldlevel = 99                      -- 打开文件不自动折起
opt.foldlevelstart = 99
opt.foldnestmax = 4                     -- 最多折 4 层, 避免过深

-- 用 neo-tree 取代内置 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
