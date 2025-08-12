return {
  "nvim-tree/nvim-web-devicons",
  lazy = false,  -- caricalo sempre (prima di neo-tree)
  config = function()
    require("nvim-web-devicons").setup({ default = true })
  end,
}

