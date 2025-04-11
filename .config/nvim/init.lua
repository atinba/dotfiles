-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("options")
require("keymaps")
require("lsp")
require("plugins")

-- Defaults
require("nvim-tree").setup()
require("gitsigns").setup()
require("neoscroll").setup()
require('spectre').setup()
require("leap").create_default_mappings()

-- Telescope
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = "close",
            },
        },
    },
}

-- Treesitter
require("nvim-treesitter.configs").setup({
    enure_installed = "all",
    sync_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" }
    },

    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
})

-- Colorscheme
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
