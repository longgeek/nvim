return {
  -- 浏览器实时预览 markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
    -- 用 :命令式 build: lazy 会先加载插件再执行该命令, 避开 build 时 autoload 未加载的 E117
    build = ":call mkdp#util#install()",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown 浏览器预览开关" },
    },
  },

  -- buffer 内实时渲染 markdown (无浏览器); 当前字体非 Nerd Font, 图标用纯文本/unicode 代替
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      sign = { enabled = false },
      heading = { icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " } },
      bullet = { icons = { "•", "◦", "▪", "▫" } },
      checkbox = {
        unchecked = { icon = "[ ] " },
        checked = { icon = "[x] " },
      },
      dash = { icon = "─" },
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Markdown buffer 内渲染开关" },
    },
  },
}
