# Neovim Keymaps Reference

> `<leader>` is typically `\` or `,` depending on your config.

---

## General (`init.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n`, `i` | `<leader>q` | Save all and quit (`:wa` + `:qa`) |
| `n` | `<leader>bd` | Close buffer (`:bd`) |
| `n` | `<leader>bD` | Force close buffer, discard changes (`:bd!`) |
| `n` | `<leader>cr` | Copy absolute file path to system clipboard |

---

## LSP (`lsp-config.lua`)

> These keymaps are active when an LSP server is attached to the buffer.

| Mode | Key | Action |
|------|-----|--------|
| `n` | `K` | Hover documentation |
| `n` | `<leader>gd` | Go to definition |
| `n` | `gD` | Go to declaration |
| `n` | `gi` | Go to implementation |
| `n` | `go` | Go to type definition |
| `n` | `gr` | Find references |
| `n` | `gs` | Signature help |
| `n` | `<F2>` | Rename symbol |
| `n`, `x` | `<F3>` | Format buffer (async) |
| `n`, `i` | `<F4>` | Code action |
| `i` | `<leader><TAB>` | Omni-completion (`<C-x><C-o>`) |
| `n` | `<leader>a` | Auto-import (lspimport) |

---

## Telescope (`telescope-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>ff` | Find files (all, including hidden) |
| `n` | `<leader>fg` | Live grep |
| `n` | `<leader>fb` | List open buffers |
| `n` | `<leader>fh` | Help tags |
| `n` | `<C-p>` | Git files |

### Telescope LSP (active when LSP is attached)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>gd` | LSP: Go to definition |
| `n` | `<leader>gr` | LSP: Find references |
| `n` | `<leader>gi` | LSP: Go to implementation |
| `n` | `<leader>gt` | LSP: Go to type definition |
| `n` | `<leader>ds` | LSP: Document symbols |
| `n` | `<leader>ws` | LSP: Workspace symbols |
| `n` | `<leader>fd` | LSP: Diagnostics (workspace) |
| `n` | `<leader>fi` | LSP: Incoming calls |
| `n` | `<leader>fo` | LSP: Outgoing calls |

---

## Debugger / DAP (`dap-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<F5>` | Continue / start debugging |
| `n` | `<F10>` | Step over |
| `n` | `<F11>` | Step into |
| `n` | `<F12>` | Step out |
| `n` | `<F13>` | Disconnect debugger |
| `n` | `<leader>b` | Toggle breakpoint |
| `n` | `<leader>B` | Set conditional breakpoint |
| `n` | `<leader>lp` | Set log point |
| `n` | `<leader>dr` | Open REPL |
| `n` | `<leader>dl` | Run last debug session |
| `n` | `<leader>dc` | Dump coroutines to REPL (Kotlin) |
| `n` | `dt` | Toggle DAP UI |
| `n` | `do` | Open DAP UI |
| `n` | `<leader>e` | Open diagnostics float |

---

## Trouble (`trouble-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>xx` | Toggle workspace diagnostics |
| `n` | `<leader>xX` | Toggle buffer diagnostics |
| `n` | `<leader>cs` | Toggle symbols panel |
| `n` | `<leader>cl` | Toggle LSP definitions/references panel |
| `n` | `<leader>xL` | Toggle location list |
| `n` | `<leader>xQ` | Toggle quickfix list |

---

## Refactoring (`nvim-refactoring.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `x` (visual) | `<leader>re` | Extract selection to function |
| `x` (visual) | `<leader>rf` | Extract selection to file |
| `x` (visual) | `<leader>rv` | Extract selection to variable |
| `n`, `x` | `<leader>ri` | Inline variable |
| `n` | `<leader>rI` | Inline function |
| `n` | `<leader>rb` | Extract block to function |
| `n` | `<leader>rbf` | Extract block to file |

---

## File Tree (`nvim-tree-config.lua` / `dadbod-ui-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>c` | Toggle nvim-tree file explorer |

---

## Terminal (`terminal-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n`, `i`, `t` | `<leader>t` | Toggle floating terminal |
| `t` | `<Esc>` | Exit terminal mode to normal mode |

---

## Neotest (`neo-test-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `tt` | Toggle test summary panel |
| `n` | `tf` | Run all tests in current working directory |

---

## Kotlin (`kotlin-config.lua`)

> Active when a Kotlin LSP is attached.

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>kf` | Format file |
| `n` | `<leader>ki` | Organize imports |
| `n` | `<leader>kh` | Toggle diagnostic hints |
| `n` | `<leader>kH` | Toggle inlay hints |
| `n` | `<leader>kd` | Decompile class file |
| `n` | `<leader>kc` | Clean LSP workspace cache |

---

## Markdown Preview (`markdown-preview-config.lua`)

> Active in markdown buffers.

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>mp` | Start Markdown Preview |
| `n` | `<leader>ms` | Stop Markdown Preview |
| `n` | `<leader>mt` | Toggle Markdown Preview |

---

## PDF (`pdf-config.lua`)

> Active in PDF buffers.

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>po` | Open PDF in macOS Preview |
| `n` | `<leader>pr` | Reload PDF text content |

---

## Diagram (`diagram-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>dv` | Render diagram under cursor (d2) |

---

## Split Navigation (`split-navigation-config.lua`)

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>1` – `<leader>9` | Jump to window 1–9 |

---

## Docker (`nvim-docker-config.lua`)

> Plugin currently disabled in `init.lua`.

| Mode | Key | Action |
|------|-----|--------|
| `n` | `<leader>C` | List Docker containers |
