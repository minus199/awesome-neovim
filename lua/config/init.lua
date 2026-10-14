-- Load editor options
require("config.options")

local utils = require("config.utils")
-- Load editor syntax, autocmds and keymaps
utils.lazy_load({ "config.syntax", "config.autocmds", "config.keymaps" })

local diagnostics_options = require("config.defaults").diagnostics_options
-- configure floating window
vim.diagnostic.config(diagnostics_options)

-- setup borders for handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = diagnostics_options.float.border,
})
--
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = diagnostics_options.float.border,
    })

-- configure diagnostics signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ", --🅴," ""󰢃 "
            [vim.diagnostic.severity.WARN] = "󰀪 ", --🆆," "
            [vim.diagnostic.severity.HINT] = "󰌶", --🅸," " "󰛩 "
            [vim.diagnostic.severity.INFO] = " ", --🅷," ","󰗡 "
        },
    },
})

-- configure debugger diagnostics signs
for name, icon in pairs(require("config.defaults").icons.debugger) do
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
