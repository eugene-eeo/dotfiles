gaps = 1

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "g", function()
    if not gaps then
        gaps = 1
        hs.alert.show("gaps: on")
    else
        gaps = false
        hs.alert.show("gaps: off")
    end
end)

local focusedWindow = function(cb)
    return function()
        local win = hs.window.focusedWindow()
        if win == nil then
            return
        end

        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        cb(f, max)
        if gaps then
            f.x = f.x + 5
            f.y = f.y + 5
            f.w = f.w - 10
            f.h = f.h - 10
        end
        win:setFrame(f)
    end
end

hs.hotkey.bind({"cmd", "alt"}, "f", function()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    win.toggleFullScreen()
end)

-- Left half of screen
hs.hotkey.bind({"cmd", "alt"}, "left", focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end))

-- Right half of screen
hs.hotkey.bind({"cmd", "alt"}, "right", focusedWindow(function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end))

-- Top left quarter
hs.hotkey.bind({"cmd", "ctrl"}, "left", focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
end))

-- Top right quarter
hs.hotkey.bind({"cmd", "ctrl"}, "right", focusedWindow(function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
end))

-- Bottom left quarter
hs.hotkey.bind({"cmd", "ctrl", "shift"}, "left", focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
end))

-- Bottom right quarter
hs.hotkey.bind({"cmd", "ctrl", "shift"}, "right", focusedWindow(function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
end))

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
