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
  		cmp.setup({
  			completion = {
  				completeopt = "menu,menuone,preview,noselect",
  			},
  			snippet = {
  				expand = function(args)
  					require("luasnip").lsp_expand(args.body)
  				end,
  			},
  			mapping = cmp.mapping.preset.insert({
  				['<C-j>'] = cmp.mapping.select_next_item(),
  				['<C-k>'] = cmp.mapping.select_prev_item(),
  				['<C-b>'] = cmp.mapping.scroll_docs(-4),
  				['<C-f>'] = cmp.mapping.scroll_docs(4),
  				['<Tab>'] = cmp.mapping.complete(),
  				['<C-e>'] = cmp.mapping.abort(),
  				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
