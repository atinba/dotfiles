local options = {
  clipboard = "unnamedplus",

  -- Searching
  smartcase = true,
  ignorecase = true,
  hlsearch = true,
  incsearch = true, 

  -- Indenting
  autoindent = true,
  shiftwidth = 4,
  smartindent = true,
  smarttab = true,
  softtabstop = 4,
  expandtab = true,
  tabstop = 4,

  list = true,
  listchars = {tab = '>.', trail = '.'},

  -- Line number
  relativenumber = true,
  numberwidth = 2,
  scrolloff = 8,

  undofile = true,
  updatetime = 300,
  -- mouse = "a",

  splitbelow = true,
  splitright = true,
  swapfile = false,

  cursorline = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
