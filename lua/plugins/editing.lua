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
      -- s 不含 x: 保留 visual (含 Ctrl-V 块) 里内置的 s 替换; flash 跳转仍在 n/o 模式可用
      { "s", mode = { "n", "o" }, function() require("flash").jump() end, desc = "Flash 跳转" },
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

  -- JSX/HTML/Vue 标签自动闭合 + 改一端同步重命名配对标签 (mini.pairs 管不到标签)
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte", "markdown" },
    opts = {},
  },

  -- 删 buffer 但保留窗口/分屏布局 (:bdelete 会连带关掉 split)
  {
    "echasnovski/mini.bufremove",
    opts = {},
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete() end, desc = "关闭 buffer (留布局)" },
    },
  },

  -- TODO/FIXME/HACK 高亮 + 复用 telescope/trouble 全项目聚合跳转
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "下个 TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "上个 TODO" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "查找 TODO" },
    },
  },

  -- 项目级查找-替换, 改动实时预览 (补 telescope live_grep 只读、不能替换的缺口)
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
    keys = {
      { "<leader>sr", function() require("grug-far").open() end, desc = "查找替换 (grug-far)" },
      { "<leader>sr", mode = "x", function() require("grug-far").with_visual_selection() end, desc = "查找替换 (选区)" },
    },
  },

  -- 行内预览颜色码 (hex/rgb/hsl/CSS 命名色/Tailwind), 写 CSS/JSX 直接看到真实颜色
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    main = "colorizer",
    opts = {
      user_default_options = { names = false, css = true, tailwind = "both" },
    },
  },

  -- 剪贴板历史: 复制过的内容存环, <leader>fy 用 telescope 翻历史
  {
    "gbprod/yanky.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("yanky").setup(opts)
      pcall(function() require("telescope").load_extension("yank_history") end)
    end,
    keys = {
      { "<leader>fy", "<cmd>Telescope yank_history<cr>", desc = "剪贴板历史" },
    },
  },

  -- 注释用 nvim 0.10+ 内置 gc / gcc / gbc, 无需插件
}
