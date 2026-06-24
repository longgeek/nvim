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

-- 用 neo-tree 取代内置 netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
