return {
  -- 发现/切换 venv (venv/uv/poetry/conda), 自动重启 basedpyright+ruff 指向正确解释器
  -- regexp 大改版已并入 main, 无需指定 branch; 依赖系统的 fd
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    ft = "python",
    cmd = "VenvSelect",
    opts = {
      options = {},
      search = {},
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "选择 Python venv" },
    },
  },
}
