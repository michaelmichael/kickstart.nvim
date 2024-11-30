return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
    'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } }, -- Optional: For prettier markdown rendering
    { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'CodeCompanionLoaded',
      callback = function()
        vim.notify 'CodeCompanion loaded successfully'
      end,
    })

    require('codecompanion').setup {
      display = {
        chat = {
          render_headers = false,
        },
      },
      providers = {
        slash_commands = 'telescope',
      },
      strategies = {
        chat = {
          adapter = 'anthropic',
          slash_commands = {
            ['file'] = {
              callback = 'strategies.chat.slash_commands.file',
              description = 'Insert a file',
              opts = {
                contains_code = true,
                max_lines = 1000,
                provider = 'telescope',
              },
            },
          },
        },
        inline = {
          adapter = 'anthropic',
        },
        agent = {
          adapter = 'anthropic',
        },
      },

      prompt_library = {
        ['git-commit'] = {
          strategy = 'chat',
          description = 'Generate a commit message and suggest splitting changes into multiple commits, if necessary.',
          opts = {
            index = 9,
            is_default = true,
            short_name = 'parse_commit',
            is_slash_cmd = true,
            auto_submit = true,
            log_level = 'DEBUG',
          },
          prompts = {
            {
              role = 'system',
              content = 'You are an expert in writing commit messages using the Conventional Commit specification.',
            },
            {
              role = 'user',
              content = function()
                local diff = vim.fn.system 'git diff --cached'
                if vim.v.shell_error ~= 0 then
                  return 'Error: No staged changes found'
                end
                return [[
Given the git diff listed below, please generate a commit message for me, including summary and enumerated changes, as appropriate. If the commit should be split into multiple smaller commits, let me know. With each suggested commit, output the files that should be included in the commit:
```diff
]] .. diff .. [[ 
```
]]
              end,
            },
          },
        },
      },

      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = os.getenv 'ANTHROPIC_API_KEY',
            },
          })
        end,
      },
    }
  end,
}
