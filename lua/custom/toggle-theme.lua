-- ~/.config/nvim/lua/custom/toggle-theme.lua

local M = {}

function M.setup()
  -- Variable to track theme state
  vim.g.is_dark = true -- Start dark

  -- Function to toggle theme
  local function toggle_theme()
    vim.g.is_dark = not vim.g.is_dark
    if vim.g.is_dark then
      vim.cmd [[colorscheme catppuccin-mocha]]
      -- Send theme change to WezTerm
      vim.fn.system 'wezterm cli set-user-var theme dark'
    else
      vim.cmd [[colorscheme catppuccin-latte]]
      -- Send theme change to WezTerm
      vim.fn.system 'wezterm cli set-user-var theme light'
    end
  end

  -- Set up the keybinding for CTRL-W t
  vim.keymap.set('n', '<C-w>t', toggle_theme, { silent = true, desc = 'Toggle theme' })

  -- Keep the leader mapping as an alternative
  vim.keymap.set('n', '<leader>tt', toggle_theme, { silent = true, desc = 'Toggle theme' })

  -- Create command
  vim.api.nvim_create_user_command('ToggleTheme', toggle_theme, {})
end

return M
