local colors = {
	-- bg = '#2E2E2E',
	bg = "#292D38",
	yellow = "#DCDCAA",
	dark_yellow = "#D7BA7D",
	cyan = "#4EC9B0",
	green = "#608B4E",
	light_green = "#B5CEA8",
	string_orange = "#CE9178",
	orange = "#FF8800",
	purple = "#C586C0",
	magenta = "#D16D9E",
	grey = "#858585",
	blue = "#569CD6",
	vivid_blue = "#4FC1FF",
	light_blue = "#9CDCFE",
	red = "#D16969",
	error_red = "#F44747",
	info_yellow = "#FFCC66",
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "ayu_mirage",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { {
			"mode",
			fmt = function()
				return ' '
			end,
            padding = 0
		} },
		lualine_b = {
			{"branch",
                icon = ' '
            },
			{
				"diff",
				symbols = { added = '  ', modified = ' 柳', removed = '  ' },
			},
			{
				"diagnostics",
				-- table of diagnostic sources, available sources:
				-- 'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'
				-- Or a function that returns a table like
				--   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
				sources = { "coc" },
				-- displays diagnostics from defined severity
				sections = { "error", "warn", "info", "hint" },
				symbols = { error = "  ", warn = "  ", info = "  ", hint = "  " },
				diagnostics_color = {
					-- Same values like general color option can be used here.
					error = { fg = colors.error_red }, -- changes diagnostic's error color
					warn = { fg = colors.orange }, -- changes diagnostic's warn color
					info = { fg = colors.info_yellow }, -- changes diagnostic's info color
					hint = { fg = colors.vivid_blue }, -- changes diagnostic's hint color
				},
				colored = true, -- displays diagnostics status in color if set to true
				update_in_insert = false, -- Update diagnostics in insert mode
				always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
			},
		},
		lualine_x = { "encoding", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
    -- in inactive tab
	inactive_sections = {
        lualine_a = {}
    },
	tabline = {},
	extensions = {},
})
