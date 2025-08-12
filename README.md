# Oliver Quin — Simple Neovim Config

This is a minimal **Neovim** configuration written in **Lua**, designed to be fast, readable, and easy to extend.  
It uses **lazy.nvim** as a package manager and is inspired by [radleylewis/nvim-lite](https://github.com/radleylewis/nvim-lite).

## Requirements

- **Neovim 0.9+**
- **lazy.nvim** (will be installed automatically if missing)
- **Git** (for plugin installation)
- Optional:
  - A Nerd Font (for icons)
  - A terminal with 24-bit (truecolor) support

## Theme
Currently set to **gruvbox**.

## Key Features

### Basic Settings
- **Line numbers** and **relative line numbers**
- Highlight current line
- Line wrap enabled (`vim.opt.wrap = true`)
- Scroll offset: 10 lines above/below cursor
- Indentation:
  - Tab width: 4 spaces
  - Tabs are not converted to spaces (`expandtab = false`)
- Search:
  - Case-insensitive by default
  - Case-sensitive if uppercase letters are used
  - Match highlighting off by default

### Visual
- Truecolor enabled (`termguicolors`)
- Always show the sign column
- Match bracket highlighting
- Transparent popup menu, max 10 items

### File Handling
- Persistent undo stored in `~/.vim/undodir`
- Backups and swap files disabled
- Auto-reload files changed externally

### Behavior
- Shared clipboard with the system
- Mouse support enabled
- Default splits: vertical to the right, horizontal below

## Key Mappings

### Window Navigation
- `<leader>h/j/k/l` → Move focus between splits
- `<leader>sv` → Vertical split
- `<leader>sh` → Horizontal split
- `<leader><Up>/<Down>` → Increase/decrease height
- `<leader><Left>/<Right>` → Increase/decrease width

### Movement & Scrolling
- `n` / `N` → Next/previous search result, centered
- `<D-d>` / `<D-u>` *(or `<C-d>` / `<C-u>` on non-Mac)* → Half page up/down, centered

### Editing
- `<A-j>` / `<A-k>` → Move line down/up
- In visual mode `<` / `>` → Indent and reselect

### File
- `<leader>e` → Open file explorer (netrw)
- `<leader>ff` → Find file
- `<leader>d` → Toggle LSP diagnostic popup

## Structure

