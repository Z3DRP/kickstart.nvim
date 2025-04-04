return {
  'EdenEast/nightfox.nvim',
  config = function()
    require('nightfox').setup {
      options = {
        styles = {
          comments = 'italic',
          --keywords = 'bold',
          --types = 'italic,bold',
        },
      },
    }
    vim.cmd.colorscheme 'terafox'
    --vim.cmd.colorscheme 'nightfox'
  end,
} -- lazy
