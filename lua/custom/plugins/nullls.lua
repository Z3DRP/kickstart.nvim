return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim/plenary.nvim' },
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier.with {
          extra_filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'css', 'scss', 'html' },
        },
      },
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          --vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
          vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
          vim.cmd [[
            augroup LspFormatting
              autocmd! * <buffer>
              autcmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
          ]]
        end
      end,
    }
  end,
}
