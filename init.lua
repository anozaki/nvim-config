vim.g.python3_host_prog = vim.fn.stdpath("config") .. "/nvim-python/bin/python3"

vim.opt.clipboard = "unnamedplus"
require("core.options")
require("core.keymaps")
require("core.lazy")
