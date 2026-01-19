# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using lazy.nvim as the plugin manager. The configuration namespace is `roose`.

## Architecture

```
init.lua                    # Entry point, loads roose module
lua/roose/
  init.lua                  # Core settings (relativenumber, scrolloff, netrw autocmd)
  remap.lua                 # Leader key (Space) and global keymaps
  lazy.lua                  # lazy.nvim bootstrap and plugin loading
  plugins/                  # Plugin specs (auto-imported by lazy.nvim)
    lsp/                    # LSP-specific plugins (lspconfig, mason)
```

Plugins are organized as individual files returning lazy.nvim spec tables. The `plugins/` and `plugins/lsp/` directories are both imported via `lazy.lua`.

## Language Support

Configured LSP servers (via mason):
- `lua_ls` - Lua (with neodev for Neovim API support)
- `clangd` - C/C++ (uses Homebrew LLVM at `/opt/homebrew/opt/llvm/bin/clangd`)

Formatters (via conform.nvim):
- `stylua` - Lua
- `clang-format` - C/C++

Treesitter parsers: c, lua, vim, vimdoc, query, java, javascript, typescript, scala, python

## Plugin Architecture Notes

- Completion: nvim-cmp with sources for LSP, LuaSnip, buffer, and path
- Snippets: LuaSnip with friendly-snippets (VSCode-style)
- Git cloning uses SSH URLs exclusively (configured in lazy.lua)
- Debug adapter: codelldb (installed via mason)
- nvim-dap-ui opens/closes automatically with debug sessions
