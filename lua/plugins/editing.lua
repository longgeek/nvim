return {
  -- 环绕 (用 gs 前缀, 避开 flash 的 s)
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa", delete = "gsd", replace = "gsr",
        find = "gsf", find_left = "gsF", highlight = "gsh",
        update_n_lines = "gsn",
      },
    },
  },
  -- 自动配对
  { "echasnovski/mini.pairs", event = "InsertEnter", opts = {} },
  -- 增强 a/i 文本对象 (af/if 等)
  { "echasnovski/mini.ai", event = "VeryLazy", opts = {} },

  -- 跳转 (easymotion + quick-scope 的现代替代)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash 跳转" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- 多光标 (Ctrl-N 选词逐个)
  { "mg979/vim-visual-multi", event = "VeryLazy" },

  -- undo 树
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo 树" } },
  },

  -- 注释用 nvim 0.10+ 内置 gc / gcc / gbc, 无需插件
}
