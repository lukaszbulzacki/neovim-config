local function start_boot(name)
    local module_name = "skynet." .. name
    local module_instance = require(module_name)
    module_instance.boot()
end

start_boot("T800")
start_boot("T1000")
