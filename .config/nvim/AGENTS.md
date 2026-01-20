# AGENTS.md

This document provides instructions and guidelines for AI agents (and human developers) working on this Neovim configuration repository.

## 1. Project Overview

This is a Neovim configuration for the user `roose`, managed by `lazy.nvim`.
- **Root Directory:** `/Users/roose/dotfiles/.config/nvim` (symlinked or direct)
- **Namespace:** `roose` (located in `lua/roose/`)
- **Plugin Manager:** `lazy.nvim`
- **Main Languages:** Lua

## 2. Build & Verification

Since this is a configuration repository, there is no traditional "build" step. Verification is primarily runtime-based.

### Reloading Configuration
Changes usually require restarting Neovim or reloading modules.
- **Restart:** The safest way to verify changes.
- **Hot Reload:** For simple plugin config changes, sourcing the file might work: `:source %` inside Neovim.

### Plugin Management
- **Sync Plugins:** Run `:Lazy sync` to install/update/clean plugins.
- **Check Status:** Run `:Lazy` to see plugin status.
- **Logs:** check `:messages` for runtime errors.

### Testing
There is no automated test suite. Verification must be manual:
1.  **Syntax Check:** Ensure code is valid Lua.
    ```bash
    luac -p lua/roose/plugins/new_plugin.lua
    ```
2.  **Runtime Verification:**
    - Open Neovim.
    - Check for startup errors (`:messages`).
    - Verify the feature/plugin added works as expected.
    - Run `:checkhealth` to verify provider/plugin health.

### Formatting & Linting
Formatting is handled by `conform.nvim`.
- **Lua:** `stylua`
- **C/C++:** `clang-format`
- **Trigger:** Manual keymap `<leader>ii` or `:lua require("conform").format()`.

## 3. Architecture & File Structure

The configuration follows a modular structure:

```
init.lua                    # Entry point. Loads 'roose' module.
lua/roose/
├── init.lua                # Core options (vim.opt).
├── lazy.lua                # Lazy.nvim bootstrap & setup.
├── remap.lua               # Global keymaps.
└── plugins/                # Plugin specifications.
    ├── init.lua            # (Optional) imports.
    ├── lsp/                # LSP-specific configurations.
    │   ├── lspconfig.lua   # LSP server setup.
    │   └── mason.lua       # Mason setup.
    └── [plugin].lua        # Individual plugin specs.
```

### Adding New Plugins
Create a new file in `lua/roose/plugins/` returning the `lazy.nvim` spec table.
```lua
return {
    "author/repo",
    event = "VeryLazy", -- or specific events like {"BufReadPre"}
    config = function()
        require("repo").setup({
            -- settings
        })
    end
}
```

## 4. Code Style Guidelines

### General Lua
- **Indentation:** 4 spaces (preferred in `plugins/`). Note: Legacy files might use 2 spaces or tabs; match the current file's style if modifying, but prefer 4 spaces for new files.
- **Strings:** Double quotes `"` are preferred over single quotes `'` for consistency with existing plugin files.
- **Semicolons:** Avoid semicolons `;` unless necessary.

### Neovim API
- **Options:** Use `vim.opt` for settings (e.g., `vim.opt.relativenumber = true`).
- **Mappings:** Use `vim.keymap.set`.
    ```lua
    vim.keymap.set("n", "<leader>xy", function() ... end, { desc = "Description" })
    ```
- **Autocommands:** Use `vim.api.nvim_create_autocmd`. Always use a group (`vim.api.nvim_create_augroup`).

### Plugin Configuration
- **Spec Format:** Return the spec table directly.
- **Lazy Loading:** Prefer lazy loading (`event`, `cmd`, `ft`, or `keys`) to keep startup time low.
- **Dependencies:** Declare dependencies explicitly in the `dependencies` table.
    ```lua
    dependencies = {
        "dependent/plugin",
        { "another/plugin", config = true },
    }
    ```

### LSP & Formatting
- **LSP Configuration:** Modify `lua/roose/plugins/lsp/lspconfig.lua`.
    - Use `vim.lsp.config` and `vim.lsp.enable` (modern/nightly API) where applicable, or standard `lspconfig` setup if sticking to stable. *Note: Current config uses `vim.lsp.config`.*
- **Capabilities:** Ensure `cmp_nvim_lsp.default_capabilities()` is passed to server configs.

### Git & SSH
- **URLs:** The `lazy.lua` configuration enforces SSH URLs.
    - `url_format = "ssh://git@github.com/%s.git"`
    - Do not hardcode `https://` URLs for GitHub plugins; use the short `user/repo` syntax.

## 5. Error Handling & Safety

- **Protected Calls:** When requiring optional modules or plugins that might not be installed, use `pcall`.
    ```lua
    local status, module = pcall(require, "module_name")
    if not status then return end
    ```
- **Check Health:** If adding a complex plugin, consider verifying if it provides a `:checkhealth` entry.

## 6. Conventions
- **Leader Key:** Space (` `) is the leader key (defined in `remap.lua` implicitly or `lazy.lua`).
- **Local Settings:** Use `vim.opt_local` for buffer-local settings.
- **Functions:** Local functions preferred over global ones unless intended for `v:lua` calls or command mapping.

## 7. Task Workflow for Agents
1.  **Analyze:** Read relevant files in `lua/roose/plugins/`.
2.  **Plan:** If adding a plugin, verify it doesn't conflict with existing ones (e.g., existing LSP setup).
3.  **Implement:** Create/edit the Lua file. Ensure strict adherence to the `return { ... }` pattern for `lazy.nvim`.
4.  **Verify:** Since you cannot run Neovim interactively:
    - Validate Lua syntax.
    - Double-check the lazy spec syntax.
    - Ensure no hardcoded paths (use `vim.fn.stdpath('data')` etc. if needed).
