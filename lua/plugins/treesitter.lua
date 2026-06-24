return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- 用稳定的 master 分支 (经典 configs.setup API); main 分支是重写, API 不同
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "python", "javascript", "typescript", "tsx", "lua", "luadoc",
        "bash", "json", "jsonc", "yaml", "sql", "markdown", "markdown_inline",
        "vim", "vimdoc", "html", "css", "toml", "dockerfile", "gitignore", "diff", "regex",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer", ["if"] = "@function.inner",
            ["ac"] = "@class.outer", ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]]"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[["] = "@class.outer" },
        },
      },
    },
  },
}
