local utils = require("lksh.utils")

local seed = utils.get_seed_from_string(vim.fn.getcwd())
require("lksh.colors").prepare_color_theme(seed)
