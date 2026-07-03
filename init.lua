-- leader 必须在 lazy 加载之前设置
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 核心配置 (不依赖插件)
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "克隆 lazy.nvim 失败:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Cursor / VSCode Neovim 下: 只加载"编辑类"插件, UI/LSP/调试交给 Cursor
local in_vscode = vim.g.vscode ~= nil
local vscode_allow = {
  ["which-key.nvim"] = true,   -- leader 面板
  ["mini.surround"] = true,
  ["mini.pairs"] = true,
  ["mini.ai"] = true,
  ["flash.nvim"] = true,       -- s 跳转
  ["vim-visual-multi"] = true, -- 多光标
  ["mini.bufremove"] = true,
  ["undotree"] = true,
  ["todo-comments.nvim"] = true,
  ["plenary.nvim"] = true,     -- todo-comments 依赖
}

-- 自动 import lua/plugins/ 下所有插件规格
require("lazy").setup({
  spec = { { import = "plugins" } },
  defaults = {
    cond = in_vscode and function(plugin)
      return vscode_allow[plugin.name] == true
    end or nil,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false },             -- 不自动检查插件更新
  change_detection = { notify = false },
  rocks = { enabled = false },               -- 不用 luarocks, 免去外部依赖
})

-- Cursor 专用键位 (调试/查找走 Cursor 命令)
if in_vscode then
  require("config.vscode")
end
