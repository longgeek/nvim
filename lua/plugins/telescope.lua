return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "找文件" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "全局 grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "buffer 列表" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "最近文件" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "帮助查找" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "搜光标下的词" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "查找快捷键 (可搜/上下选/回车执行)" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "当前 buffer 搜行" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
