return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load Catppuccin first so it's available for other plugins
    opts = {
      flavour = "frappe", -- Specify the Frappé flavor
      background = {
        light = "latte",
        dark = "frappe",
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
