return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local map = vim.keymap.set
    local opts = { silent = true, noremap = true }
    map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", opts)
    map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", opts)
    map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", opts)
    map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", opts)
  end,
}
