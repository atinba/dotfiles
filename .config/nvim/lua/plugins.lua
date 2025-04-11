local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Have packer manage itself
    use("nvim-lua/popup.nvim")    -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim")  -- Useful lua functions used by lots of plugins
    use("neovim/nvim-lspconfig")
    use("nvim-telescope/telescope.nvim")
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use("tpope/vim-surround")

    use("ggandor/leap.nvim")
    use("navarasu/onedark.nvim")
    use { "ellisonleao/gruvbox.nvim" }
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    }

    use("dense-analysis/ale")

    use("p00f/nvim-ts-rainbow")
    use("lewis6991/gitsigns.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("tpope/vim-repeat")
    use("karb94/neoscroll.nvim")
    use("nvim-pack/nvim-spectre")

    -- Collection of configurations for built-in LSP client
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use("hrsh7th/nvim-cmp")                            -- Autocompletion plugin
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })  -- buffer auto-completion
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })    -- path auto-completion
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }) -- cmdline auto-completion
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional
        },
    })
    use("folke/zen-mode.nvim")

    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use("windwp/nvim-ts-autotag")
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end

    -- Packer
    use "sindrets/diffview.nvim"
end)
