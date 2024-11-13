return {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicon', opt = true },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'terafox',
        section_seperators = { left = '>', right = '<' },
        component_seperators = { left = '|', right = '|' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1 } }, -- 0: just file name 1: relative path 2: abs path
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
