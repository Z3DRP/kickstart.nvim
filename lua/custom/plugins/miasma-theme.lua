--return {
--'xero/miasma.nvim',
--branch = 'dev',
--dependencies = {
--'rktjmp/lush.nvim',
--'rktjmp/shipwright.nvim',
--},
--lazy = false,
--qqpriority = 1000,
--config = function()
-- vim.cmd 'colorscheme miasma'
--end,
-- }
-- darkearth theme based off miasma
return {
  'ptdewey/darkearth-nvim',
  priority = 1000,
  config = function()
    --    vim.cmd 'colorscheme darkearth'
  end,
}
