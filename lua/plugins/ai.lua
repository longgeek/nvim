return {
  -- AI 补全: Codeium (免费, 替代 Copilot)。
  -- 首次使用需 :Codeium Auth 登录 (浏览器取 token 粘回终端)。
  -- 内联虚拟文本建议; Alt-l 接受 (Ghostty 需开 Option as Meta)。
  {
    "Exafunction/windsurf.nvim", -- 原 Exafunction/codeium.nvim, 免费
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false, -- 用虚拟文本, 不进 nvim-cmp 列表
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<M-h>",
          },
        },
      })
    end,
  },
}
