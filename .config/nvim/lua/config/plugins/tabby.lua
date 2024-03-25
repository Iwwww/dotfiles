return {
  name = "tabby",
  dir = "~/builds/tabby/clients/vim",
  enabled = true,
  config = function()
    vim.g.tabby_server_url = "http://localhost:8080"
    vim.g.tabby_accept_binding = '<Tab>'
    vim.g.tabby_dismiss_binding = '<C-]>'
  end,
}
