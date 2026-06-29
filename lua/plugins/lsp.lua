return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/SchemaStore.nvim", -- package.json/tsconfig/Actions 等的 JSON/YAML schema 目录
    },
    config = function()
      -- 诊断外观
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.INFO] = "»",
            [vim.diagnostic.severity.HINT] = "⚑",
          },
        },
      })

      -- 让所有 server 带上 cmp 的补全能力
      local caps = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        caps = vim.tbl_deep_extend("force", caps, cmp_lsp.default_capabilities())
      end
      vim.lsp.config("*", { capabilities = caps })

      -- server 特定设置
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
            diagnostics = { globals = { "vim" } },
            hint = { enable = true }, -- inlay hints
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.config("basedpyright", {
        settings = { basedpyright = { analysis = { typeCheckingMode = "standard" } } },
      })
      -- ts_ls inlay hints 默认关, 显式打开
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
            },
          },
        },
      })
      -- jsonls/yamlls 挂 SchemaStore: package.json/tsconfig/.eslintrc/Actions 自动补全+校验
      vim.lsp.config("jsonls", {
        settings = {
          json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
        },
      })
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" }, -- 关掉内置, 改用 SchemaStore.nvim
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      -- mason 自动安装并启用 (mason-lspconfig v2 会 vim.lsp.enable)
      -- basedpyright/ruff/sqls 用系统包管理器装 (见 DESIGN.md「安装」), 下方手动启用
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "ts_ls", "eslint", "bashls", "jsonls", "yamlls",
        },
      })

      -- 系统包管理器装的 server, 手动启用 (binary 在 PATH)
      vim.lsp.enable({ "basedpyright", "ruff" })

      -- sqls (SQL LSP) 装到 ~/go/bin 后自动启用。安装:
      --   GOPROXY=https://goproxy.cn,direct go install github.com/sqls-server/sqls@latest
      local sqls_bin = vim.fn.expand("~/go/bin/sqls")
      if vim.uv.fs_stat(sqls_bin) then
        vim.lsp.config("sqls", { cmd = { sqls_bin } })
        vim.lsp.enable("sqls")
      end

      -- buffer 级 LSP 键位
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my_lsp_attach", { clear = true }),
        callback = function(ev)
          -- 0.11 默认在 gr 前缀挂了 grn/gra/grr/gri, 删掉腾出干净的 gd/gr/gi
          for _, k in ipairs({ "grn", "gra", "grr", "gri" }) do
            pcall(vim.keymap.del, "n", k, { buffer = ev.buf })
          end
          local function map(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
          end
          map("gd", "<cmd>Telescope lsp_definitions<CR>", "定义")
          map("gr", "<cmd>Telescope lsp_references<CR>", "引用")
          map("gi", "<cmd>Telescope lsp_implementations<CR>", "实现")
          map("gy", "<cmd>Telescope lsp_type_definitions<CR>", "类型定义")
          map("K", vim.lsp.buf.hover, "悬浮文档")
          map("<leader>cr", vim.lsp.buf.rename, "重命名符号")
          map("<leader>ca", vim.lsp.buf.code_action, "code action", { "n", "x" })
          map("<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", "文档符号")

          -- inlay hints: 行内显示推断的类型/参数名 (支持的 server 自动开)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end
          map("<leader>ci", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
          end, "切换 inlay hints")
        end,
      })
    end,
  },

  -- 非 LSP 的格式化器/linter 由 mason 统一安装
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = { "stylua", "prettierd", "shfmt", "shellcheck", "debugpy" },
    },
  },

  -- 诊断/quickfix/符号 面板 (逐条扫错)
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "诊断面板 (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "本 buffer 诊断" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "符号大纲" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
    },
  },
}
