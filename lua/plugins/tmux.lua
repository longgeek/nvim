return {
  -- C-h/j/k/l 在 nvim 窗格与 tmux 窗格间无缝移动
  -- 注: 完整跨 tmux 需在 ~/.tmux.conf 加上配套 C-hjkl 绑定 (见配置说明)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp", "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "移到左窗格" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "移到下窗格" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "移到上窗格" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "移到右窗格" },
    },
  },
}
