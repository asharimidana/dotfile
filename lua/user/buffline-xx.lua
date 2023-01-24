local close_func = function(bufnum)
  local bufdelete_avail, bufdelete = pcall(require, "bufdelete")
  if bufdelete_avail then
    bufdelete.bufdelete(bufnum, true)
  else
    vim.cmd.bdelete { args = { bufnum }, bang = true }
  end
end
require("bufferline").setup({
  options = {
    offsets = {
      { filetype = "NvimTree", text = "", padding = 1 },
      { filetype = "neo-tree", text = "", padding = 1 },
      { filetype = "Outline", text = "", padding = 1 },
    },
    buffer_close_icon = "x",
    modified_icon = "*",
    close_icon = "x",
    close_command = close_func,
    right_mouse_command = close_func,
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    separator_style = "thin",
  },
})
local highlights = require "bufferline.highlights"
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroColorScheme",
  group = "BufferlineCmds",
  desc = "Bufferline apply colors after astronvim colorscheme change",
  callback = function()
    highlights.reset_icon_hl_cache()
    highlights.set_all(require("bufferline.config").update_highlights())
  end,
})

