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
  config = function()
    vim.keymap.set('n', '<leader>Fsl', ':Neotree filesystem reveal left<CR>', {})
    vim.keymap.set('n', '<leader>Fsc', ':Neotree close <CR>', {})
    vim.keymap.set('n', '<leader>Fsf', ':Neotree buffers reveal float<CR>', {})
  end,
}
