return {
  -- 主题 (换主题: 改这里 style 或换插件 + 下面 colorscheme 名)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- 图标 (lualine / neo-tree 依赖)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- 键位提示: 按下 <leader> 后弹出可用键
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>f", group = "查找 (find)" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "git hunk" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "调试 (debug)" },
        { "<leader>b", group = "buffer" },
        { "<leader>s", group = "分屏 (split)" },
        { "<leader>x", group = "诊断 (diagnostics)" },
        { "<leader>m", group = "markdown" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "本 buffer 键位" },
    },
  },

  -- 缩进参考线
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = { scope = { enabled = true } },
  },
}
