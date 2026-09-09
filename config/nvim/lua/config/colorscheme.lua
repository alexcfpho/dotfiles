return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load Catppuccin first so it's available for other plugins
    opts = {
      flavour = "mocha", -- Specify the Mocha flavor
      background = {
        light = "latte",
        dark = "mocha",
      },
    },
  },

  -- Configure LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

