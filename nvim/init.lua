-- load basic vimrc
local script_path = debug.getinfo(1, "S").source:match("^@(.+)$")
local script_dir = script_path:match("^(.*[\\/])")
vim.cmd('source ' .. script_dir .. '/vimrc')

-- pathogen
vim.fn['pathogen#infect']('plugins/{}')

-- oil.vim
require("oil").setup()

-- telescope.nvim
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

if os.getenv('TERM') ~= 'linux' then
  -- colorscheme
  vim.o.background = 'dark'
  vim.cmd.colorscheme "off"

  -- transparent background
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'Terminal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'Folded', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
end

