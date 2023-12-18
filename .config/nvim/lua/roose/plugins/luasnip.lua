return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
 	event = "InsertEnter",
	dependencies = {
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful VSCode-style snippets
	},
	config = function()
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
	end
}
