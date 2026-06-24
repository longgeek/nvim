return {
  -- 浏览器实时预览 markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    -- 用 :命令式 build: lazy 会先加载插件再执行该命令, 避开 build 时 autoload 未加载的 E117
    build = ":call mkdp#util#install()",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown 预览开关" },
    },
  },
}
