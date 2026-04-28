return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  keys = {
    -- Toggle opencode TUI terminal (right split) -- consistent with \ac (claude) and \gc (gemini)
    { "<leader>oc", function() require("opencode").toggle() end, desc = "Toggle opencode" },

    -- Send current visual selection to opencode (append only, does not submit) -- consistent with \as (claude) and \ga (gemini)
    { "<leader>os", function() require("opencode").prompt("@this") end, mode = "v", desc = "Send to opencode" },

    -- Ask (open input box, type freely)
    { "<leader>oa", function() require("opencode").ask() end, mode = { "n", "v" }, desc = "Ask opencode" },

    -- Select menu (prompts / commands / server)
    { "<leader>oo", function() require("opencode").select() end, mode = { "n", "v" }, desc = "opencode select menu" },

    -- Quick prompts (no input box, send immediately)
    { "<leader>oe", function() require("opencode").prompt("Explain @this", { submit = true }) end, mode = { "n", "v" }, desc = "Explain selection" },
    { "<leader>of", function() require("opencode").prompt("Fix @diagnostics", { submit = true }) end, desc = "Fix diagnostics" },
    { "<leader>or", function() require("opencode").prompt("Review @this", { submit = true }) end, mode = { "n", "v" }, desc = "Review selection" },
    { "<leader>ot", function() require("opencode").prompt("Add tests for @this", { submit = true }) end, mode = { "n", "v" }, desc = "Add tests" },
    { "<leader>od", function() require("opencode").prompt("Review the following git diff: @diff", { submit = true }) end, desc = "Review git diff" },
    { "<leader>oi", function() require("opencode").prompt("Implement @this", { submit = true }) end, mode = { "n", "v" }, desc = "Implement selection" },

    -- Operator mode (select with motion/text-object, supports dot-repeat)
    { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
    { "goo", function() return require("opencode").operator("@this ") .. "_" end, desc = "Add line to opencode", expr = true },

    -- Session management
    { "<leader>oS", function() require("opencode").select_session() end, desc = "Select session" },
    { "<leader>on", function() require("opencode").command("session.new") end, desc = "New session" },
    { "<leader>ox", function() require("opencode").command("session.interrupt") end, desc = "Interrupt session" },
  },
  config = function()
    vim.g.opencode_opts = {
      server = { port = nil },
      lsp = { enabled = false },
      events = {
        enabled = true,
        reload = true,
        permissions = {
          enabled = true,
          edits = { enabled = true },
        },
      },
    }
  end,
}
