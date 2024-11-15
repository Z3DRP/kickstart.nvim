return {
  'nvim-telescope/telescope-file-browser.nvim',
  requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      defaults = {
        mappings = {
          n = {
            ['<C-d>'] = function(prompt_bufnr)
              local action_state = require 'telescope.actions.state'
              local actions = require 'telescope.actions'
              local selected_entry = action_state.get_selected_entry()
              local file_path = selected_entry.path or selected_entry.filename

              if file_path then
                vim.fn.delete(file_path)
                actions.close(prompt_bufnr)
                print('Delete file(s): ' .. file_path)
              else
                print 'No file selected'
              end
            end,
          },
        },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
        },
      },
    }
    telescope.load_extension 'file_browser'
    vim.keymap.set('n', '<leader>Fb', ':Telescope file_browser<CR>', { noremap = true, silent = true })
  end,
}
