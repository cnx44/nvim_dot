return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
		  visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,

        },
      },
      window = {
        mappings = {
          ["<space>"] = "open",
          ["<cr>"] = "noop",
          ["e"] = "close_window",
        },
      },
    })
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
  end,
}
