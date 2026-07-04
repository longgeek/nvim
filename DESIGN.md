# Neovim 配置设计

手写模块化配置, 基于 `lazy.nvim`。目标: 现代 IDE 能力, 但每行可读可维护、无发行版黑盒。

## 要求

- Neovim ≥ 0.11 (用现代 LSP API: `vim.lsp.config` / `vim.lsp.enable`, mason-lspconfig v2)
- 外部命令: git、ripgrep(rg)、fd (telescope 用)、node/npm、go、python3
- 终端开启真彩色 + 系统剪贴板 (配合 tmux 时尤佳)

## 目录结构

```
~/.config/nvim/
├── init.lua              # 入口: 设 leader=Space, bootstrap lazy, require config.*
├── lazy-lock.json        # 插件版本锁
├── DESIGN.md
└── lua/
    ├── config/
    │   ├── options.lua   # vim 选项
    │   ├── keymaps.lua   # 不依赖插件的全局键位
    │   └── autocmds.lua  # 自动命令
    └── plugins/          # 每文件 return 一组插件规格, lazy 自动 import
        ├── lsp.lua  completion.lua  treesitter.lua  telescope.lua
        ├── ui.lua   filetree.lua    git.lua         editing.lua
        ├── format-lint.lua  dap.lua  ai.lua  markdown.lua  tmux.lua
```

一个能力 = 一个文件, 增删互不干扰。

## 插件清单

| 关注点 | 插件 |
|---|---|
| 管理器 | folke/lazy.nvim |
| LSP | nvim-lspconfig + mason + mason-lspconfig |
| 补全 | nvim-cmp + LuaSnip + friendly-snippets |
| 语法 | nvim-treesitter (+textobjects) |
| 模糊查找 | telescope.nvim + fzf-native |
| 文件树 | neo-tree.nvim |
| Git | gitsigns.nvim + vim-fugitive |
| 状态栏 / 键位提示 / 图标 | lualine + which-key + nvim-web-devicons |
| tmux 导航 | christoomey/vim-tmux-navigator |
| 编辑 | mini.surround/pairs/ai + flash.nvim + vim-visual-multi + undotree |
| 格式化 + lint | conform.nvim + nvim-lint |
| AI 补全 | Exafunction/windsurf.nvim (Codeium, 免费) |
| 调试 | nvim-dap + dap-ui + nvim-dap-python |
| Markdown | markdown-preview.nvim |

## LSP / 语言

mason 自动安装并启用: `lua_ls`、`ts_ls`、`eslint`、`bashls`、`jsonls`、`yamlls`。
系统包管理器安装、配置里手动启用: `basedpyright` + `ruff` (Python)、`sqls` (SQL)。

利用 Neovim 0.11+ 内置 LSP 默认键, 其余在 `LspAttach` 里按 buffer 绑定。

## 键位 (leader = Space)

保留习惯: `H`=行首 `L`=行尾; `j/k` 走可视行; `C-h/j/k/l` 跨 nvim+tmux 窗格; 切 buffer 用 `Tab`/`S-Tab`。

| 键 | 功能 | 键 | 功能 |
|---|---|---|---|
| `<leader>e` | 文件树 | `gd`/`gr`/`gi` | 定义/引用/实现 |
| `<leader>ff` | 找文件 | `K` | 悬浮文档 |
| `<leader>fg` | 全局 grep | `<leader>cr` | 重命名符号 |
| `<leader>fb`/`fr` | buffer/最近 | `<leader>ca` | code action |
| `<leader>/` | buffer 内搜行 | `[d`/`]d` | 上/下诊断 |
| `<leader>gg` | Git (fugitive) | `<leader>cf` | 格式化 |
| `<leader>hs`/`hr` | stage/reset hunk | `]c`/`[c` | 上/下 git hunk |
| `<leader>db`/`dc` | 断点/继续 | `<leader>du` | DAP UI |
| `<leader>j` | flash 跳转 | `<leader>mp` | Markdown 预览 |

`s` 保持原生 substitute (normal + Ctrl-V 块选均删字进插入); flash 跳转故意让出 `s`,挪到 `<leader>j`。`S` 仍为 flash-treesitter 选区。

折叠 (treesitter 按语法, 默认全展开): `za` 切换 · `zc`/`zo` 关/开 · `zM`/`zR` 全折/全展 · `zj`/`zk` 跳折叠。Cursor 下折叠走 VSCode 原生 (treesitter 不加载), 键位由 vscode-neovim 映射。

按 `<leader>` 由 which-key 弹出全部可用键。

## options / autocmds 要点

`number`+`relativenumber`、`termguicolors`、`clipboard=unnamedplus`、`undofile`、
`ignorecase`+`smartcase`、`signcolumn=yes`、`scrolloff=8`、`splitright/below`、`mouse=a`;
Python 4 空格缩进。复制时高亮、重开记住光标位置、写入前自动建父目录。

## 主题

`tokyonight` (night)。换主题改 `lua/plugins/ui.lua` 一行。

## 安装

- 插件: 首次启动 lazy 自动安装, 或 `:Lazy sync`。
- mason 工具: `:Mason` 查看 (lua_ls / ts_ls / eslint / bashls / jsonls / yamlls / stylua / prettierd / shfmt / shellcheck / debugpy)。
- Python LSP: `brew install ruff basedpyright`。
- SQL LSP: `GOPROXY=https://goproxy.cn,direct go install github.com/sqls-server/sqls@latest` (装到 `~/go/bin` 后自动启用)。
- AI: 在 nvim 内 `:Codeium Auth` 登录。

## 不在范围 (YAGNI)

不引入会话管理、project 切换、dashboard 启动页、通知 UI 美化等。需要再加。
```
