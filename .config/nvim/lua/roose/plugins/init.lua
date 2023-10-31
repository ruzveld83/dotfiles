return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		-- split window vertically when opening help
		"anuvyklack/help-vsplit.nvim",
		config = function()
			require('help-vsplit').setup()
		end,
	}
}
