#/usr/bin/lua

function popen_last(command)
    -- get the last line of output from `command`
    local f = io.popen(command)
    local last = ""
    for line in f:lines() do
        last = line
    end
    return last
end


methods = { "xkb:us::eng", "pinyin" }
current = popen_last("ibus engine")
for index, method in ipairs(methods) do
    if method == current then
        os.execute("ibus engine " .. methods[(index) % (#methods) + 1])
        os.execute("herbstclient emit_hook ibus")
        break
    end
end
