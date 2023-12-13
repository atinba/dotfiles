local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
    return
end

local ac = require "telescope.actions"


telescope.setup {
  defaults = {
    mappings = {
      i = {
	["<esc>"] = ac.close,
      },
      n = {
        ["?"] = ac.which_key,
      },
    },
  },
}
