return {
  	"hrsh7th/nvim-cmp",
   	event = "InsertEnter",
   	dependencies = {
   		"hrsh7th/cmp-buffer", -- source for text in buffer
   		"hrsh7th/cmp-path", -- source for file system paths
   		"L3MON4D3/LuaSnip", -- snippet engine, configured separately
   	},
   	config = function()
  		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
		end

  		cmp.setup({
  			completion = {
  				completeopt = "menu,menuone,preview,noselect",
  			},
  			snippet = {
  				expand = function(args)
  					luasnip.lsp_expand(args.body)
  				end,
  			},
  			mapping = cmp.mapping.preset.insert({
  				['<C-j>'] = cmp.mapping.select_next_item(),
  				['<C-k>'] = cmp.mapping.select_prev_item(),
  				['<C-b>'] = cmp.mapping.scroll_docs(-4),
  				['<C-f>'] = cmp.mapping.scroll_docs(4),
  				['<C-e>'] = cmp.mapping.abort(),
  				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				-- Taken from https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
  			}),
  			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
  				{ name = "luasnip" },
  				{ name = "buffer" },
  				{ name = "path" },
  			}),
  		})
   	end
}
