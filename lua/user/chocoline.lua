--[[ local get_hex = require("cokeline.utils").get_hex
local active_bg_color = '#931E9E'
local inactive_bg_color = get_hex('Normal', 'bg')
local bg_color = get_hex('ColorColumn', 'bg')
require('cokeline').setup({
	show_if_buffers_are_at_least = 1,
	mappings = {
		cycle_prev_next = true
	},
	default_hl = {
		bg = function(buffer)
			if buffer.is_focused then
				return active_bg_color
			end
		end,
	},
	sidebar = {
		filetype = 'neo-tree',
		components = {
			{
				text = '  Explorer',
				fg = yellow,
				bg = get_hex('NvimTreeNormal', 'bg'),
				style = 'italic',
			},
		}
	},
	components = {
		{
			text = function(buffer)
				local _text = ''
				if buffer.index > 1 then _text = ' ' end
				if buffer.is_focused or buffer.is_first then
					_text = _text .. '|'
				end
				return _text
			end,
			fg = function(buffer)
				if buffer.is_focused then
					return active_bg_color
				elseif buffer.is_first then
					return inactive_bg_color
				end
			end,
			bg = function(buffer)
				if buffer.is_focused then
					if buffer.is_first then
						return bg_color
					else
						return inactive_bg_color
					end
				elseif buffer.is_first then
					return bg_color
				end
			end
		},
		{
			text = function(buffer)
				local status = ''
				if buffer.is_readonly then
					status = '➖'
				elseif buffer.is_modified then
					status = '*'
				end
				return status
			end,
		},
		{
			text = function(buffer)
				return " " .. buffer.devicon.icon
			end,
			fg = function(buffer)
				if buffer.is_focused then
					return buffer.devicon.color
				end
			end
		},
		{
			text = function(buffer)
				return buffer.unique_prefix .. buffer.filename
			end,
			fg = function(buffer)
				if (buffer.diagnostics.errors > 0) then
					return '#C95157'
				end
			end,
			style = function(buffer)
				local text_style = 'NONE'
				if buffer.is_focused then
					text_style = 'bold'
				end
				if buffer.diagnostics.errors > 0 then
					if text_style ~= 'NONE' then
						text_style = text_style .. ',underline'
					else
						text_style = 'underline'
					end
				end
				return text_style
			end
		},
		{
			text = function(buffer)
				local errors = buffer.diagnostics.errors
				if (errors <= 9) then
					errors = ''
				else
					errors = "🙃"
				end
				return errors .. ' '
			end,
			fg = function(buffer)
				if buffer.diagnostics.errors == 0 then
					return '#3DEB63'
				elseif buffer.diagnostics.errors <= 9 then
					return '#DB121B'
				end
			end
		},
		{
			text = '',
			delete_buffer_on_left_click = true
		},
		{
			text = function(buffer)
				if buffer.is_focused or buffer.is_last then
					return ''
				else
					return ' '
				end
			end,
			fg = function(buffer)
				if buffer.is_focused then
					return active_bg_color
				elseif buffer.is_last then
					return inactive_bg_color
				else
					return bg_color
				end
			end,
			bg = function(buffer)
				if buffer.is_focused then
					if buffer.is_last then
						return bg_color
					else
						return inactive_bg_color
					end
				elseif buffer.is_last then
					return bg_color
				end
			end
		}
	},
})

 ]]

vim.opt.termguicolors = true
require("bufferline").setup {
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
		close_command = function(bufnr) -- can be a string | function, see "Mouse actions"
			M.buf_kill("bd", bufnr, false)
		end,
		right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		--[[ indicator = {
			icon = lvim.icons.ui.BoldLineLeft, -- this should be omitted if indicator style is not 'icon'
			style = "icon", -- can also be 'underline'|'none',
		},
		buffer_close_icon = lvim.icons.ui.Close,
		modified_icon = lvim.icons.ui.Circle,
		close_icon = lvim.icons.ui.BoldClose,
		left_trunc_marker = lvim.icons.ui.ArrowCircleLeft,
		right_trunc_marker = lvim.icons.ui.ArrowCircleRight, ]]

		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
			-- remove extension from markdown files for example
			if buf.name:match "%.md" then
				return vim.fn.fnamemodify(buf.name, ":t:r")
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = diagnostics_indicator,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = custom_filter,
		offsets = {
			{
				filetype = "neo-tree",
				text = "VIM IDE",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "flutterToolsOutline",
				text = "Flutter Outline",
				highlight = "PanelHeading",
			},
			{
				filetype = "packer",
				text = "Packer",
				highlight = "PanelHeading",
				padding = 1,
			},
		},
		color_icons = true, -- whether or not to add the filetype icon highlights
		-- show_buffer_icons = lvim.use_icons, -- disable filetype icons for buffers
		-- show_buffer_close_icons = lvim.use_icons,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin",
		enforce_regular_tabs = false,
		always_show_bufferline = false,
		hover = {
			enabled = false, -- requires nvim 0.8+
			delay = 200,
			reveal = { "close" },
		},
		sort_by = "id",
	},
    highlights = {
      background = {
        italic = true,
      },
      buffer_selected = {
        bold = true,
      },
    },
}
