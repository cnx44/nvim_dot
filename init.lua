-- ==================================================
-- Simple NVIM config, by Oliver Quin
-- Using lazy as package manger
-- More requirments in README
-- Credits to https://github.com/radleylewis/nvim-lite
-- for inspo and the greate tutorial
-- ===================================================
-- Theme managed in lua/plugins/colorscheme.lua
-- currently gruvbox

-- Basic settings
vim.opt.number = true                              -- Line numbers
vim.opt.relativenumber = true                      -- Relative line numbers
vim.opt.cursorline = true                          -- Highlight current line
vim.opt.wrap = true								   -- Wrap lines
vim.opt.scrolloff = 10                             -- Keep 10 lines above/below cursor 

-- Indentation
vim.opt.tabstop = 4                                -- Tab width
vim.opt.shiftwidth = 4                             -- Indent width
vim.opt.softtabstop = 4                            -- Soft tab stop
vim.opt.expandtab = false						   -- Use spaces instead of tabs
vim.opt.smartindent = true                         -- Smart auto-indenting
vim.opt.autoindent = true                          -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = false                           -- Don't highlight search results 
vim.opt.incsearch = true                           -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                       -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                         -- Always show sign column
vim.opt.showmatch = true                           -- Highlight matching brackets
vim.opt.matchtime = 10                             -- How long to show matching bracket
vim.opt.cmdheight = 1                              -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options 
vim.opt.showmode = false                           -- Don't show mode in command line 
vim.opt.pumheight = 10                             -- Popup menu height 
vim.opt.pumblend = 10                              -- Popup menu transparency 
vim.opt.winblend = 0                               -- Floating window transparency 
vim.opt.conceallevel = 0                           -- Don't hide markup 
vim.opt.concealcursor = ""                         -- Don't hide cursor line markup 
vim.opt.lazyredraw = true                          -- Don't redraw during macros
vim.opt.synmaxcol = 300                            -- Syntax highlighting limit 

-- File handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.updatetime = 300                           -- Faster completion
vim.opt.timeoutlen = 500                           -- Key timeout duration
vim.opt.ttimeoutlen = 0                            -- Key code timeout
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save

-- Behavior settings
vim.opt.hidden = true                              -- Allow hidden buffers
vim.opt.errorbells = false                         -- No error bells
vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
vim.opt.autochdir = false                          -- Don't auto change directory
vim.opt.path:append("**")                          -- include subdirectories in search
vim.opt.selection = "exclusive"                    -- Selection behavior
vim.opt.mouse = "a"                                -- Enable mouse support
vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard
vim.opt.modifiable = true                          -- Allow buffer modifications
vim.opt.encoding = "UTF-8"                         -- Set encoding

-- Split behavior
vim.opt.splitbelow = true                          -- Horizontal splits go below
vim.opt.splitright = true                          -- Vertical splits go right

-- Key mappings
vim.g.mapleader = " "                              -- Set leader key to spaces

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Half screen jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader><Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader><Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader><Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader><Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down with alt (option) in both viasual and normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep selected after indentation
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- File navigator
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- LSP Message pop up (toggle)
local diag_win = nil

local function is_floating(win)
  local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
  return ok and cfg and cfg.relative ~= ""
end

vim.keymap.set("n", "<A-d>", function()
  -- se c'è già e *è* una floating, chiudila
  if diag_win and vim.api.nvim_win_is_valid(diag_win) and is_floating(diag_win) then
    pcall(vim.api.nvim_win_close, diag_win, true)
    diag_win = nil
    return
  end

  -- apri il float e memorizza la nuova floating window
  local before = vim.api.nvim_list_wins()
  vim.diagnostic.open_float(nil, { focus = false })
  local after = vim.api.nvim_list_wins()

  -- trova la window nuova che è floating
  diag_win = nil
  for _, w in ipairs(after) do
    local found = true
    for _, b in ipairs(before) do
      if w == b then found = false break end
    end
    if found and is_floating(w) then
      diag_win = w
      break
    end
  end
end, { desc = "Toggle LSP diagnostic popup", noremap = true, silent = true })

-- Lazy
require("config.lazy")
