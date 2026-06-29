return {
  -- 编辑器内跑/看测试: 行旁标红绿、跳失败、可 dap 调试单个用例
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python", -- Python (pytest/unittest)
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({ dap = { justMyCode = false } }),
        },
      })
    end,
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "跑最近的测试" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "跑当前文件" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "调试最近测试" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "测试概览侧栏" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "查看测试输出" },
      { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "监视测试 (改动自动跑)" },
    },
  },
}
