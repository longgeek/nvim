return {
  -- .http 文件里发 REST/GraphQL/gRPC/WebSocket 请求, 支持 .env, 请求随代码入库; 底层走 curl
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {},
    keys = {
      { "<leader>Rs", function() require("kulala").run() end, desc = "发送请求" },
      { "<leader>Ra", function() require("kulala").run_all() end, desc = "发送全部请求" },
      { "<leader>Rr", function() require("kulala").replay() end, desc = "重放上次请求" },
    },
  },
}
