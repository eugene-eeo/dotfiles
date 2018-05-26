local currentSpace = function(cb)
    return function()
        local win = hs.window.filter.new():setCurrentSpace(true)
        if win == nil then
            return
        end
        cb(win)
    end
end

focus_left  = currentSpace(function(win) win:focusWindowWest(nil, false, true) end)
focus_right = currentSpace(function(win) win:focusWindowEast(nil, false, true) end)
focus_top   = currentSpace(function(win) win:focusWindowNorth(nil, false, true) end)
focus_bot   = currentSpace(function(win) win:focusWindowSouth(nil, false, true) end)

hs.window.animationDuration = 0
hs.grid.setGrid('8x4')
hs.grid.setMargins(hs.geometry(nil, nil, 5, 5))

local focusedWindow = function(cb)
    return function()
        local win = hs.window.focusedWindow()
        if win == nil then
            return
        end
        cb(win)
        hs.grid.snap(win)
    end
end

function fullscreen()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    win:toggleFullScreen()
end

-- taken from https://gist.github.com/koekeishiya/dc48db74f4fdbfbf5648
-- thanks kokeshiya!
-- draws a border around the currently focused window
border = nil

function drawBorder()
    if border then
        border:delete()
    end

    local win = hs.window.focusedWindow()
    if win == nil then return end

    local f = win:frame()
    local fx = f.x - 2
    local fy = f.y - 2
    local fw = f.w + 4
    local fh = f.h + 4

    border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
    border:setStrokeWidth(3)
    border:setStrokeColor({["red"]=1,["blue"]=1,["green"]=1,["alpha"]=1.0})
    border:setRoundedRectRadii(5, 5)
    border:setStroke(true):setFill(false)
    border:setLevel("floating")
    border:show()
end

drawBorder()

windows = hs.window.filter.new(nil)
windows:subscribe(hs.window.filter.windowFocused, function () drawBorder() end)
windows:subscribe(hs.window.filter.windowUnfocused, function () drawBorder() end)
windows:subscribe(hs.window.filter.windowMoved, function () drawBorder() end)

-- Key Bindings
hs.hotkey.bind({"cmd", "ctrl"}, "f", fullscreen)

-- Focus
hs.hotkey.bind({"alt", "ctrl"}, "left",  focus_left)
hs.hotkey.bind({"alt", "ctrl"}, "down",  focus_bot)
hs.hotkey.bind({"alt", "ctrl"}, "up",    focus_top)
hs.hotkey.bind({"alt", "ctrl"}, "right", focus_right)

hs.hotkey.bind({"alt", "cmd"}, "up",    focusedWindow(hs.grid.pushWindowUp))
hs.hotkey.bind({"alt", "cmd"}, "down",  focusedWindow(hs.grid.pushWindowDown))
hs.hotkey.bind({"alt", "cmd"}, "left",  focusedWindow(hs.grid.pushWindowLeft))
hs.hotkey.bind({"alt", "cmd"}, "right", focusedWindow(hs.grid.pushWindowRight))

hs.hotkey.bind({"alt", "cmd"}, "=", focusedWindow(hs.grid.resizeWindowTaller))
hs.hotkey.bind({"alt", "cmd"}, "-", focusedWindow(hs.grid.resizeWindowShorter))
hs.hotkey.bind({"alt", "cmd", "shift"}, "=", focusedWindow(hs.grid.resizeWindowWider))
hs.hotkey.bind({"alt", "cmd", "shift"}, "-", focusedWindow(hs.grid.resizeWindowThinner))
hs.hotkey.bind({"alt", "cmd"}, "g", hs.grid.show)
