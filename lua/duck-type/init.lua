package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path

local Util = require("duck-type.util")

print(Util.buffer_to_string())
