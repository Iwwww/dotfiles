return {
    "nvim-tree/nvim-web-devicons",
    -- nothing renders icons before the first frame (lualine/tree/telescope are lazy)
    event = "VeryLazy",
    config = function()
        require("nvim-web-devicons").set_icon({
            gql = {
                icon = "",
                color = "#e535ab",
                cterm_color = "199",
                name = "GraphQL",
            },
        })
    end,
}
