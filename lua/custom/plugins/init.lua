-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '<leader>gg', ':Neogit<cr>', { desc = 'Open Lazygit' })
vim.keymap.set('n', '<leader>v', ':e ~/.config/nvim/init.lua<cr>', { desc = 'Edit nvim config file' })
vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', { desc = 'Open/Close NeoTree' })
vim.keymap.set('n', '<leader>C', ':CodeCompanionChat<cr>', { desc = 'Open Code Companion Chat' })
vim.keymap.set('v', '<leader>cc', ':CodeCompanionActions<cr>', { desc = 'Open Code Companion' })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['typescript'] = { 'prettier' },
        ['typescriptreact'] = { 'prettier' },
        ['javascript'] = { 'prettier' },
        ['javascriptreact'] = { 'prettier' },
        ['svelte'] = { 'prettier' },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = false,
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tsserver = {
          settings = {
            typescript = {
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
