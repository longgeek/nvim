return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "mfussenegger/nvim-dap-python",
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "断点开关" },
      { "<leader>dc", function() require("dap").continue() end, desc = "继续/启动" },
      { "<F5>", function() require("dap").continue() end, desc = "调试继续" },
      { "<leader>do", function() require("dap").step_over() end, desc = "step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "step out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "终止调试" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI 开关" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Python: 用 mason 装的 debugpy
      local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      if vim.uv.fs_stat(debugpy) then
        require("dap-python").setup(debugpy)
      else
        require("dap-python").setup("python3")
      end
      -- JS/TS 调试需要额外的 js-debug-adapter, 见配置说明 (默认未启用)
    end,
  },
}
