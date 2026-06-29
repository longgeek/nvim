return {
  -- 行内 git 标记 + hunk 操作
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = buf, desc = desc })
        end
        map("]c", function() gs.nav_hunk("next") end, "下个 git hunk")
        map("[c", function() gs.nav_hunk("prev") end, "上个 git hunk")
        map("<leader>hs", gs.stage_hunk, "stage hunk")
        map("<leader>hr", gs.reset_hunk, "reset hunk")
        map("<leader>hp", gs.preview_hunk, "预览 hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "行 blame")
        map("<leader>gb", function() gs.blame_line({ full = true }) end, "行 blame")
      end,
    },
  },

  -- :Git 全功能 (status/commit/diff/blame...), 你已熟悉
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gblame" },
    keys = {
      { "<leader>gg", "<cmd>Git<CR>", desc = "Git 状态" },
      { "<leader>gl", "<cmd>Git log --oneline<CR>", desc = "Git log" },
    },
  },

  -- lazygit 浮窗 (需系统装好 lazygit)
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" },
    keys = {
      { "<leader>gz", "<cmd>LazyGit<CR>", desc = "lazygit 浮窗" },
    },
  },
}
