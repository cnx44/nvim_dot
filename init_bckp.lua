vim.g.mapleader = " "
require("config.lazy")

vim.opt.termguicolors = true

vim.opt.number = true

-- larghezza visiva del carattere tab
vim.opt.tabstop = 4
-- quanti spazi usare per indentazione
vim.opt.shiftwidth = 4
-- se vuoi usare veri tab invece di spazi
vim.opt.expandtab = false

-- TODO: trovare un modo sensato per togglare 
--vim.opt.relativenumber = true

-- LSP floating diagnostic window toggler
local diag_win = nil

vim.keymap.set("n", "<leader>d", function()
  if diag_win and vim.api.nvim_win_is_valid(diag_win) then
    -- chiudi il popup
    vim.api.nvim_win_close(diag_win, true)
    diag_win = nil
  else
    -- crea il popup e salva il suo ID
    vim.diagnostic.open_float(nil, { focus = false })
    local wins = vim.api.nvim_list_wins()
    diag_win = wins[#wins]  -- ultimo creato = il popup
  end
end, { desc = "Toggle LSP diagnostic popup" })


-- Normal mode → movimento istantaneo
vim.keymap.set("n", "<leader>j", "]}", { noremap = true, silent = true, desc = "Go to block end" })
vim.keymap.set("n", "<leader>k", "[{", { noremap = true, silent = true, desc = "Go to block start" })

-- Operator-pending e Visual → mantieni come motion
vim.keymap.set({ "o", "x" }, "<leader>j", "]}", { noremap = true, silent = true })
vim.keymap.set({ "o", "x" }, "<leader>k", "[{", { noremap = true, silent = true })


-- LSP signature help popup toggler
local sig_win = nil

vim.keymap.set("n", "<leader>i", function()
  if sig_win and vim.api.nvim_win_is_valid(sig_win) then
    vim.api.nvim_win_close(sig_win, true)
    sig_win = nil
  else
    local before = vim.api.nvim_list_wins()
    vim.lsp.buf.signature_help()
    -- aspetta che la floating window venga creata e catturane l'ID
    vim.defer_fn(function()
      local after = vim.api.nvim_list_wins()
      for _, w in ipairs(after) do
        local known = false
        for _, b in ipairs(before) do
          if w == b then known = true; break end
        end
        if not known then sig_win = w; break end
      end
    end, 10)
  end
end, { desc = "Toggle LSP signature help" })

-- Normal mode
vim.keymap.set('n', '<D-c>', '<C-c>')
vim.keymap.set('n', '<C-c>', '<D-c>')

-- Insert mode
vim.keymap.set('i', '<D-c>', '<C-c>')
vim.keymap.set('i', '<C-c>', '<D-c>')

vim.keymap.set('n', '<D-s>', '<C-s>')
vim.keymap.set('n', '<C-s>', '<D-s>')

