return {
  "maxmx03/solarized.nvim",
  config = function()
    local success, solarized = pcall(require, "solarized")

    vim.o.background = "dark"

    solarized:setup({
      config = {
        theme = "neovim",
        transparent = false,
      },
    })

    vim.cmd("colorscheme solarized")
  end,
}
