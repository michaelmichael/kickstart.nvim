return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest',
    'marilari88/neotest-vitest',
  },
  config = function()
    local neotest = require 'neotest'

    -- Helper function to get current file
    local get_current_file = function()
      return vim.fn.expand '%'
    end

    -- Setup neotest
    neotest.setup {
      -- Adapters
      adapters = {
        require 'neotest-vitest' {
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        },
      },

      -- General Settings
      log_level = 3, -- Log level (1-4, 4 being most verbose)
      consumers = {}, -- Allows registration of custom consumers

      -- Icons for the UI
      icons = {
        child_indent = '│',
        child_prefix = '├',
        collapsed = '─',
        expanded = '╮',
        failed = '',
        final_child_indent = ' ',
        final_child_prefix = '╰',
        non_collapsible = '─',
        passed = '',
        running = '',
        skipped = '',
        unknown = '',
        watching = '',
      },

      -- UI Customization
      highlights = {
        adapter_name = 'NeotestAdapterName',
        border = 'NeotestBorder',
        dir = 'NeotestDir',
        failed = 'NeotestFailed',
        passed = 'NeotestPassed',
        running = 'NeotestRunning',
        skipped = 'NeotestSkipped',
        test = 'NeotestTest',
      },

      floating = {
        border = 'rounded',
        max_height = 0.6,
        max_width = 0.6,
        options = {},
      },

      -- Test Running Configuration
      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },

      run = {
        enabled = true,
      },

      -- Summary Window Configuration
      summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
        count = true,
        open = 'botright vsplit | vertical resize 50',
        mappings = {
          attach = 'a',
          clear_marked = 'M',
          clear_target = 'T',
          debug = 'd',
          debug_marked = 'D',
          expand = { '<CR>', '<2-LeftMouse>' },
          expand_all = 'e',
          jumpto = 'i',
          mark = 'm',
          next_failed = 'J',
          output = 'o',
          prev_failed = 'K',
          run = 'r',
          run_marked = 'R',
          short = 'O',
          stop = 'u',
          target = 't',
          watch = 'w',
        },
      },

      -- Output Configuration
      output = {
        enabled = true,
        open_on_run = 'short',
      },

      output_panel = {
        enabled = true,
        open = 'botright split | resize 15',
      },

      -- Additional Features
      quickfix = {
        enabled = true,
        open = false,
      },

      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },

      state = {
        enabled = true,
      },

      watch = {
        enabled = true,
      },

      diagnostic = {
        enabled = true,
        severity = 1,
      },

      projects = {},
    }

    -- Define keybindings
    -- Test Running
    vim.keymap.set('n', ',nt', function()
      neotest.run.run()
    end, { desc = 'Run nearest test' })

    vim.keymap.set('n', ',nf', function()
      neotest.run.run(get_current_file())
    end, { desc = 'Run all tests in current file' })

    vim.keymap.set('n', ',nl', function()
      neotest.run.run_last()
    end, { desc = 'Run last test' })

    vim.keymap.set('n', ',nS', function()
      neotest.run.run { suite = true }
    end, { desc = 'Run entire test suite' })

    vim.keymap.set('n', ',nx', function()
      neotest.run.stop()
    end, { desc = 'Stop running tests' })

    vim.keymap.set('n', ',nd', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug nearest test' })

    -- Output & Display
    vim.keymap.set('n', ',ns', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle test summary panel' })

    vim.keymap.set('n', ',no', function()
      neotest.output.open { enter = true }
    end, { desc = 'Open test output' })

    vim.keymap.set('n', ',na', function()
      neotest.output.open { enter = true, auto_close = true }
    end, { desc = 'Show output in popup (auto-close)' })

    vim.keymap.set('n', ',nO', function()
      neotest.output.open { short = true }
    end, { desc = 'Show short output summary' })

    vim.keymap.set('n', ',np', function()
      neotest.output_panel.toggle()
    end, { desc = 'Toggle output panel' })

    -- Navigation
    vim.keymap.set('n', ',nj', function()
      neotest.jump.next { status = 'failed' }
    end, { desc = 'Jump to next failed test' })

    vim.keymap.set('n', ',nk', function()
      neotest.jump.prev { status = 'failed' }
    end, { desc = 'Jump to previous failed test' })

    -- Watch Mode
    vim.keymap.set('n', ',nw', function()
      neotest.watch.toggle(get_current_file())
    end, { desc = 'Toggle watching current file' })

    vim.keymap.set('n', ',nq', function()
      neotest.watch.stop(get_current_file())
    end, { desc = 'Stop watching current file' })

    -- Marking Tests
    vim.keymap.set('n', ',nm', function()
      neotest.summary.run_marked()
    end, { desc = 'Run marked tests' })

    vim.keymap.set('n', ',nM', function()
      neotest.summary.clear_marked()
    end, { desc = 'Clear marked tests' })
  end,
}
