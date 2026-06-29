return {
  -- 语法解析/高亮: main 分支 (neovim 0.12+ 的重写版; master 已废弃, 与新 treesitter API 不兼容)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main 分支不支持懒加载
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "python", "javascript", "typescript", "tsx", "lua", "luadoc",
        "bash", "json", "yaml", "sql", "markdown", "markdown_inline",
        "vim", "vimdoc", "html", "css", "toml", "dockerfile", "gitignore", "diff", "regex",
      })
      -- jsonc 没有独立解析器, 复用 json
      vim.treesitter.language.register("json", "jsonc")
      -- 有解析器的 filetype 自动开高亮 + treesitter 缩进
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- 文本对象: 函数/类/参数的选择与跳转 (main 分支 API)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })
      local sel = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local map = vim.keymap.set
      -- 选择 (visual / operator-pending)
      map({ "x", "o" }, "af", function() sel.select_textobject("@function.outer", "textobjects") end, { desc = "函数 outer" })
      map({ "x", "o" }, "if", function() sel.select_textobject("@function.inner", "textobjects") end, { desc = "函数 inner" })
      map({ "x", "o" }, "ac", function() sel.select_textobject("@class.outer", "textobjects") end, { desc = "类 outer" })
      map({ "x", "o" }, "ic", function() sel.select_textobject("@class.inner", "textobjects") end, { desc = "类 inner" })
      map({ "x", "o" }, "aa", function() sel.select_textobject("@parameter.outer", "textobjects") end, { desc = "参数 outer" })
      map({ "x", "o" }, "ia", function() sel.select_textobject("@parameter.inner", "textobjects") end, { desc = "参数 inner" })
      -- 跳转
      map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "下一个函数" })
      map({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "下一个类" })
      map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "上一个函数" })
      map({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "上一个类" })
    end,
  },

  -- 滚动时顶部固定显示当前函数/类 (sticky context)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { max_lines = 3, multiline_threshold = 1 },
  },
}
