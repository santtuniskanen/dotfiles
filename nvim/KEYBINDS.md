# Neovim Keybinds

> `<leader>` is `Space`

## Navigation

| Key | Action |
|-----|--------|
| `<leader>w` | Toggle whitespace markers |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `n` | Next search result (centered) |
| `N` | Prev search result (centered) |

## Quickfix

| Key | Action |
|-----|--------|
| `<leader>q` | Toggle quickfix window |
| `]q` | Next quickfix item |
| `[q` | Prev quickfix item |

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `K` | Show docs popup (press again to close) |
| `<C-k>` | Signature help (insert mode) |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>lf` | Format file |
| `<leader>ih` | Toggle inlay hints |

## Completion

| Key | Action |
|-----|--------|
| `<Tab>` | Next completion item |
| `<S-Tab>` | Prev completion item |
| `<CR>` | Confirm selection |

## Finder

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fs` | Grep word under cursor |
| `<leader>fr` | Recent files |
| `<leader>fb` | Open buffers |
| `<leader>fd` | Diagnostics |

## Terminal

| Key | Action |
|-----|--------|
| `<leader>t` | Open terminal float |

## Git

| Key | Action |
|-----|--------|
| `<leader>gd` | Git diff (current file) |
| `<leader>gb` | Git blame (current file) |

## Editing
| Key | Action |
|-----|--------|
| `o` / `O` | New line below/above and insert |
| `A` / `I` | Insert at end/start of line |
| `ci"` / `ci(` | Change inside quotes/parens (works with `d`, `y` too) |
| `gg=G` | Re-indent entire file |
| `J` | Join line below to current |
| `~` | Toggle case of character |
| `<C-a>` / `<C-x>` | Increment/decrement number under cursor |

## Navigation

| Key | Action |
|-----|--------|
| `%` | jump to matching bracket/paren
| `*` | search for word under cursor
| `''` | jump back to last position
| `<C-o> / <C-i>` | jump back/forward through jump history

## Visual Mode
| Key | Action |
|-----|--------|
| `V` | Linewise visual select |
| `o` | Move cursor to other end of selection |
| `gv` | Reselect last visual selection |
| `>` / `<` | Indent/unindent selection |
| `<S-Down>` / `<S-Up>` | Move selected lines down/up |

## Marks
| Key | Action |
|-----|--------|
| `ma` | Set mark `a` |
| `` `a `` | Jump to mark `a` |
