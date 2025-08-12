return {
  {
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme gruvbox")
      vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
      vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")
      vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
    end,
  },
}

