local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-vitest"),
        require("neotest-plenary").setup({
            -- this is my standard location for minimal vim rc
            -- in all my projects
            min_init = "./scripts/tests/minimal.vim",
        }),
    }
})

vim.keymap.set("n", "<leader>tc", function()
    neotest.run.run()
end)

vim.keymap.set("n", "<leader>tf", function()
    neotest.run.run(vim.fn.expand("%"))
end)
