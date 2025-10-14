-- opts {{{

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true
vim.o.confirm = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.foldmethod = "marker"
vim.o.lmap = "йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/?"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.cmd('packadd! nohlsearch')

-- }}}

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

vim.keymap.set(
    {"n"},
    "<C-e>",
    ":Oil<enter>"
)

-- lazy.nvim {{{
    -- not plugins {{{
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
    -- }}}

require("lazy").setup({
  spec = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "nvim-lualine/lualine.nvim", dependencies = { 'nvim-tree/nvim-web-devicons' },
    { "stevearc/oil.nvim", dependencies = { { "nvim-mini/mini.icons", opts = {} } }, lazy = false, },
    { "norcalli/nvim-colorizer.lua" },
    { "mrjones2014/smart-splits.nvim" }
}
  },
  install = { colorscheme = { "catppuccin" } },
  vim.cmd.colorscheme "catppuccin-mocha",
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local home = os.getenv("HOME")
loadfile(home.."/.config/nvim/oilcfg.lua")()
loadfile(home.."/.config/nvim/lualinecfg.lua")()

vim.lsp.enable("csharp-language-server")

-- resizing splits
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

-- }}}
