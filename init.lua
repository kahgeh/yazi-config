-- Bookmarks plugin configuration
require("bookmarks"):setup({
	persist = "all",          -- Save all bookmarks across sessions
	desc_format = "full",     -- Show full path in bookmark list
	file_pick_mode = "hover", -- Bookmark the hovered file/directory
	notify = {
		enable = true,
		message = {
			new = "Bookmark '<key>' saved",
			delete = "Bookmark '<key>' deleted",
			delete_all = "All bookmarks deleted",
		},
	},
	show_keys = true,         -- Show available keys when saving
	custom_desc_input = false, -- Don't prompt for custom description
})
