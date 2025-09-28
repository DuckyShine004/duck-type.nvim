local duck_type = require("duck-type")

pcall(duck_type.setup, vim.g.duck_type_opts or {})
