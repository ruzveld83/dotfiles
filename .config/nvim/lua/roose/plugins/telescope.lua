return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				config = function() require("telescope").load_extension("fzf") end
			},
			'nvim-tree/nvim-web-devicons'
		},
		keys = {
			{ "<leader>ff", function() require('telescope.builtin').find_files() end },
			{ "<leader>fg", function() require('telescope.builtin').live_grep() end },
			{ "<leader>fr", function() require('telescope.builtin').oldfiles() end },
		},
		config = function()
			require("telescope").setup {
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
						}
					}
				},
			}
		end
	},
}

