-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal <CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        visible = true,
      },
    },
  },
  -- config = function()
  --   vim.keymap.set('n', '\\', ':Neotree filesystem reveal left<CR>', {})
  --   vim.keymap.set('n', '\\', ':Neotree close <CR>', {})
  --   vim.keymap.set('n', '<leader>Fsf', ':Neotree buffers reveal float<CR>', {})
  -- end,
}
