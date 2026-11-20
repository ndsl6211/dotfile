-- opencode TUI command and terminal window, shared by the toggle keymap and server.start
local opencode_cmd = "opencode"
local opencode_terminal_opts = {
  win = { position = "right", enter = false },
}

local function send_keys(keys)
  local terminal = require("snacks.terminal").get(opencode_cmd, vim.tbl_deep_extend("force", opencode_terminal_opts, { create = false }))
  if not terminal then
    vim.notify("Open the OpenCode terminal with <leader>oc first", vim.log.levels.WARN)
    return
  end
  vim.api.nvim_chan_send(vim.bo[terminal.buf].channel, keys)
end

local function append_context()
  local text
  if vim.bo.filetype == "NvimTree" then
    -- Send file path to opencode
    local node = require("nvim-tree.api").tree.get_node_under_cursor()
    if not node or not node.absolute_path then
      return
    end
    text = node.absolute_path .. " "
  else
    local cursor = vim.api.nvim_win_get_cursor(0)
    local from = { cursor[1], cursor[2] + 1 }
    local to
    local mode = vim.fn.mode()
    if mode:match("[vV\022]") then
      local anchor = vim.fn.getpos("v")
      from = { anchor[2], anchor[3] }
      to = { cursor[1], cursor[2] + 1 }
      if from[1] > to[1] or (from[1] == to[1] and from[2] > to[2]) then
        from, to = to, from
      end
      if mode == "V" then
        from = { from[1] }
        to = { to[1] }
      end
    end
    text = require("opencode").format({ buf = 0, from = from, to = to, rel = vim.fn.getcwd() }) .. " "
  end

  send_keys("\027[200~" .. text .. "\027[201~")
end

return {
  "nickjvandyke/opencode.nvim",
  branch = "main",
  version = false,
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(picker)
              local items = vim.tbl_map(function(item)
                return item.file
                  and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                  or item.text
              end, picker:selected({ fallback = true }))
              picker:close()
              require("opencode").ask(table.concat(items, ", ") .. " ")
            end,
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
    { "<leader>oc", function() require("snacks.terminal").toggle(opencode_cmd, opencode_terminal_opts) end, desc = "Toggle opencode" },

    -- Append current context to the OpenCode input without submitting
    { "<leader>os", append_context, mode = { "n", "v" }, desc = "Send to opencode" },

    -- Ask (open input box, type freely)
    { "<leader>oa", function() require("opencode").ask("@this ") end, mode = { "n", "v" }, desc = "Ask opencode" },

    -- Select menu (prompts / commands)
    { "<leader>oo", function() require("opencode").select() end, mode = { "n", "v" }, desc = "opencode select menu" },

    -- Quick prompts (no input box, send immediately)
    { "<leader>oe", function() require("opencode").prompt("Explain @this") end, mode = { "n", "v" }, desc = "Explain selection" },
    { "<leader>of", function() require("opencode").prompt("Fix @diagnostics") end, desc = "Fix diagnostics" },
    { "<leader>or", function() require("opencode").prompt("Review @this") end, mode = { "n", "v" }, desc = "Review selection" },
    { "<leader>ot", function() require("opencode").prompt("Add tests for @this") end, mode = { "n", "v" }, desc = "Add tests" },
    { "<leader>od", function() require("opencode").prompt("Review the following git diff: @diff") end, desc = "Review git diff" },
    { "<leader>oi", function() require("opencode").prompt("Implement @this") end, mode = { "n", "v" }, desc = "Implement selection" },

    -- Operator mode (select with motion/text-object, supports dot-repeat)
    { "go", function() return require("opencode").operator("@this ...") end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
    { "goo", function() return require("opencode").operator("@this ...") .. "_" end, desc = "Add line to opencode", expr = true },

    -- Session management
    { "<leader>on", function() send_keys("\024n") end, desc = "New session" },
    { "<leader>ox", function() send_keys("\027") end, desc = "Interrupt session" },
  },
  config = function()
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, opencode_terminal_opts)
        end,
      },
      events = {
        enabled = true,
        reload = {
          enabled = true,
        },
        permissions = {
          enabled = true,
          edits = { enabled = true },
        },
      },
    }
  end,
}
