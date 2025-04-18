local function init()
  local wilder = require('wilder')

  wilder.setup({
    modes = {':', '/', '?'},
    next_key = '<Tab>',
    previous_key = '<S-Tab>',
    accept_key = '<Down>',
    reject_key = '<Up>',

    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          set_pcre2_pattern = 1,
        }),
        wilder.python_search_pipeline({
          pattern = 'fuzzy',
        })
      ),
    })
  })
end

return {
  'gelguy/wilder.nvim',
  enabled = false,
}
