return {
  -- 轻量 DB IDE: 侧栏浏览连接/库/表, buffer 里跑 SQL 看结果, 查询文件可入 git
  -- 底层 tpope/vim-dadbod (纯 vimscript 引擎); dadbod-completion 给 nvim-cmp 加 schema 感知补全
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "数据库 UI (dadbod)" },
    },
  },
}
