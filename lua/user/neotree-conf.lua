local neonn = require('neo-tree')

local config = {
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
	add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab

	close_floats_on_escape_key = true,
	default_source = "filesystem",
	enable_diagnostics = true,
	enable_git_status = true,
	enable_modified_markers = true, -- Show markers for files with unsaved changes.
	enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
	git_status_async = true,
	-- These options are for people with VERY large git repos
	git_status_async_options = {
		batch_size = 1000, -- how many lines of git status results to process at a time
		batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
		max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
		-- Anything before this will be used. The last items to be processed are the untracked files.
	},
	hide_root_node = true, -- Hide the root node.
	retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
	-- This is needed if you use expanders because they render in the indent.
	log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
	log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
	open_files_in_last_window = true, -- false = open files in top left window
	popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
	resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
	-- set to -1 to disable the resize timer entirely
	--                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil, -- uses a custom function for sorting files and directories in the tree
	use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
	use_default_mappings = true,
	-- source_selector provides clickable tabs to switch between sources.
	source_selector = {
		winbar = true, -- toggle to show selector on winbar
		statusline = true, -- toggle to show selector on statusline
		show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
		-- of the top visible node when scrolled down.
		tab_labels = { -- falls back to source_name if nil
			filesystem = "  Files ",
			buffers = "  Buffers ",
			git_status = "  Git ",
			diagnostics = " 裂Diagnostics ",
		},
		content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
		--                start  : |/ 裡 bufname     \/...
		--                end    : |/     裡 bufname \/...
		--                center : |/   裡 bufname   \/...
		tabs_layout = "equal", -- start, end, center, equal, focus
		truncation_character = "…", -- character to use when truncating the tab label
		tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
		tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
		padding = 0, -- can be int or table
		-- padding = { left = 2, right = 0 },
		separator = { left = "▏", right = "▕" },
		separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
		show_separator_on_edge = false,
		--                       true  : |/    a    \/    b    \/    c    \|
		--                       false : |     a    \/    b    \/    c     |
	},

	default_component_configs = {
		container = {
			enable_character_fade = true,
			width = "100%",
			right_padding = 0,
		},
		indent = {
			indent_size = 2,
			padding = 1,
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon"
		},
		modified = {
			symbol = "[+] ",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			--highlight = "NeoTreeFileName",
			--ashari
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
				deleted   = "✖",
				modified  = "",
				renamed   = "",
				-- Status type
				untracked = "X",
				ignored   = "",
				unstaged  = "",
				staged    = "",
				conflict  = "",
			},
			align = "right",
		},
	},
	renderers = {
		directory = {
			{ "indent" },
			{ "icon" },
			{ "current_filter" },
			{
				"container",
				content = {
					{ "name", zindex = 10 },
					{ "clipboard", zindex = 10 },
					{ "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
					{ "git_status", zindex = 20, align = "right", hide_when_expanded = true },
				},
			},
		},
		file = {
			{ "indent" },
			{ "icon" },
			{
				"container",
				content = {
					{
						"name",
						zindex = 10
					},
					{ "clipboard", zindex = 10 },
					{ "bufnr", zindex = 10 },
					{ "modified", zindex = 20, align = "right" },
					{ "diagnostics", zindex = 20, align = "right" },
					{ "git_status", zindex = 20, align = "right" },
				},
			},
		},
		message = {
			{ "indent", with_markers = false },
			{ "name", highlight = "NeoTreeMessage" },
		},
		terminal = {
			{ "indent" },
			{ "icon" },
			{ "name" },
			{ "bufnr" }
		}
	},
	nesting_rules = {},
	window = {
		position = "left", -- left, right, top, bottom, float, current
		width = 30, -- applies to left and right positions
		height = 15, -- applies to top and bottom positions
		auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
		popup = { -- settings that apply to float position only
			size = {
				height = "80%",
				width = "50%",
			},
			position = "50%", -- 50% means center it
			-- you can also specify border here, if you want a different setting from
		},

		-- You can also create your own commands by providing a function instead of a string.
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
			},
			["R"] = "refresh",
			["a"] = {
				"add",
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none" -- "none", "relative", "absolute"
				}
			},
			["A"] = "add_directory", -- also accepts the config.show_path option.
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the config.show_path option
			["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
			["e"] = "toggle_auto_expand_width",
			["q"] = "close_window",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		},
	},
	filesystem = {
		hide_gitignored = true,
		hide_hidden = true, -- only works on Windows for hidden files/directories
		hide_by_name = {
			"node_modules"
		},
		hide_by_pattern = { -- uses glob style patterns
			--"*.meta",
			--"*/src/*/tsconfig.json",
		},
		always_show = { -- remains visible even if other settings would normally hide it
			".gitignored",
		},
		never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
			"node_modules",
		},
		never_show_by_pattern = { -- uses glob style patterns
			--".null-ls_*",
		},
		window = {
			mappings = {
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["f"] = "filter_on_submit",
				["."] = "set_root",
			},
		},
		async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
		bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
		cwd_target = {
			sidebar = "tab", -- sidebar is when position = left or right
			current = "window" -- current is when position = current
		},

		find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
		hide_by_name = {
			"node_modules"
		},
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		search_limit = 50, -- max number of search results when using filters
		follow_current_file = true, -- This will find and focus the file in the active buffer every time
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
	},
	buffers = {
		bind_to_cwd = true,
		follow_current_file = true, -- This will find and focus the file in the active buffer every time
		-- the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty directories will be grouped together
		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["bd"] = "buffer_delete",
			},
		},
	},
	git_status = {
		window = {
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
	example = {
		renderers = {
			custom = {
				{ "indent" },
				{ "icon", default = "C" },
				{ "custom" },
				{ "name" }
			}
		},
		window = {
			mappings = {
				["<cr>"] = "toggle_node",
				["<C-e>"] = "example_command",
				["d"] = "show_debug_info",
			},
		},
	},
}
neonn.setup(config)
