return {
  -- 'shaunsingh/nord.nvim',
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   -- Example config in lua
  --   vim.g.nord_contrast = true
  --   vim.g.nord_borders = false
  --   vim.g.nord_disable_background = true
  --   vim.g.nord_italic = false
  --   vim.g.nord_uniform_diff_background = true
  --   vim.g.nord_bold = false
  --
  --   -- Load the colorscheme
  --   require('nord').set()
  --
  --   -- Toggle background transparency
  --   local bg_transparent = true
  --
  --   local toggle_transparency = function()
  --     bg_transparent = not bg_transparent
  --     vim.g.nord_disable_background = bg_transparent
  --     vim.cmd [[colorscheme nord]]
  --   end
  --
  --   vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  -- end,

  -- *** --

  -- 'folke/tokyonight.nvim',
  -- priority = 1000, -- Make sure to load this before all the other start plugins.
  -- init = function()
  --   -- Load the colorscheme here.
  --   -- Like many other themes, this one has different styles, and you could load
  --   -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --   vim.cmd.colorscheme 'tokyonight-night'
  --
  --   -- You can configure highlights by doing something like:
  --   vim.cmd.hi 'Comment gui=none'
  -- end,


  -- *** --

  -- 'dracula/vim',
  -- as = 'dracula',
  -- config = function()
  --   vim.cmd [[colorscheme dracula]]
  -- end,

  -- *** --

  -- 'https://github.com/folke/nightfox.nvim',
  -- as = 'nightfox',
  -- config = function()
  --   require('nightfox').setup {
  --     options = {
  --       transparent = true, -- Пример дополнительной настройки
  --     },
  --   }
  --   vim.cmd [[colorscheme nightfox]]
  -- end,

  -- *** --

  -- 'joshdick/onedark.vim',
  -- as = 'onedark',
  -- config = function()
  --   vim.cmd [[colorscheme onedark]]
  --   -- Пример дополнительных настроек
  --   vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
  -- end,
  --
  --

  -- *** --

  -- 'EdenEast/nightfox.nvim',
  -- config = function()
  --   require('nightfox').setup {
  --     options = {
  --       -- Пример дополнительных настроек
  --       styles = {
  --         comments = 'italic',
  --         keywords = 'bold',
  --         functions = 'italic,bold',
  --       },
  --     },
  --   }
  --   vim.cmd 'colorscheme carbonfox'
  -- end,

  -- *** --
  --
  -- 'EdenEast/nightfox.nvim',
  -- config = function()
  --   require('nightfox').setup {
  --     options = {
  --       -- Пример настроек стилей
  --       styles = {
  --         comments = 'italic',
  --         keywords = 'bold',
  --         types = 'italic,bold',
  --       },
  --     },
  --   }
  --   vim.cmd 'colorscheme terafox'
  -- end,

  -- *** --
  --
  -- "catppuccin/nvim",
  -- name = "catppuccin",
  -- priority = 1000, -- чтобы тема грузилась первой
  -- config = function()
  --   require("catppuccin").setup({
  --     flavour = "latte", -- latte = светлая, frappe/maccchiato/mocha = тёмные
  --     transparent_background = false,
  --     integrations = {
  --       cmp = true,
  --       treesitter = true,
  --       mason = true,
  --       nvimtree = true,
  --       native_lsp = {
  --         enabled = true,
  --         virtual_text = {
  --           errors = { "italic" },
  --           hints = { "italic" },
  --           warnings = { "italic" },
  --           information = { "italic" },
  --         },
  --         underlines = {
  --           errors = { "underline" },
  --           hints = { "underline" },
  --           warnings = { "underline" },
  --           information = { "underline" },
  --         },
  --       },
  --     },
  --   })
  --   vim.cmd.colorscheme "catppuccin-mocha"
  -- end,
  "projekt0n/github-nvim-theme",
  config = function()
    require("github-theme").setup({ theme_style = "light" })
    vim.cmd("colorscheme github_light")
  end
}
