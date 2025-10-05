return {
  "ldelossa/gh.nvim",
  dependencies = {
    {
      "ldelossa/litee.nvim",
      config = function()
        require("litee.lib").setup({
          panel = {
            orientation = "right",  -- 可以是 "left", "right", "top", "bottom"
            panel_size = 75,        -- 面板大小（預設是30）
          }
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
    }
  },
  config = function()
    require("litee.gh").setup({
      keymaps = {
        -- when inside a gh.nvim panel, this key will open a node if it has
        -- any futher functionality. for example, hitting <CR> on a commit node
        -- will open the commit's changed files in a new gh.nvim panel.
        open = "<CR>",
        -- when inside a gh.nvim panel, expand a collapsed node
        expand = "zo",
        -- when inside a gh.nvim panel, collpased and expanded node
        collapse = "zc",
        -- when cursor is over a "#1234" formatted issue or PR, open its details
        -- and comments in a new tab.
        goto_issue = "gd",
        -- show any details about a node, typically, this reveals commit messages
        -- and submitted review bodys.
        details = "d",
        -- inside a convo buffer, submit a comment
        submit_comment = "<C-s>",
        -- inside a convo buffer, when your cursor is ontop of a comment, open
        -- up a set of actions that can be performed.
        actions = "<C-a>",
        -- inside a thread convo buffer, resolve the thread.
        resolve_thread = "<C-r>",
        -- inside a gh.nvim panel, if possible, open the node's web URL in your
        -- browser. useful particularily for digging into external failed CI
        -- checks.
        goto_web = "gx"
      }
    })

    vim.keymap.set("n", "<leader>ghco", ":GHOpenToCommit<CR>")
    vim.keymap.set("n", "<leader>ghcc", ":GHCloseCommit<CR>")

    vim.keymap.set("n", "<leader>ghpo", ":GHOpenPR<CR>")
    vim.keymap.set("n", "<leader>ghpc", ":GHClosePR<CR>")
    vim.keymap.set("n", "<leader>ghr", ":GHOpenPR<CR>")

    vim.cmd("FzfLua register_ui_select")
  end,
}
