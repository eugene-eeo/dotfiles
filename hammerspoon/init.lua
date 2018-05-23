gaps = true

function toggle_gaps()
    if not gaps then
        gaps = true
        hs.alert.show("gaps: on")
    else
        gaps = false
        hs.alert.show("gaps: off")
    end
end

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

local focusedWindow = function(cb)
    return function()
        local win = hs.window.focusedWindow()
        if win == nil then
            return
        end

        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        local isFull = cb(f, max)
        if not isFull and gaps then
            f.x = f.x + 5
            f.y = f.y + 5
            f.w = f.w - 10
            f.h = f.h - 10
        end
        win:setFrame(f, 0)
    end
end

function fullscreen()
    local win = hs.window.focusedWindow()
    if win == nil then
        return
    end
    win:toggleFullScreen()
end

maximise = focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    return true
end)

resize_left = focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end)

resize_right = focusedWindow(function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end)

resize_top_left = focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
end)

resize_top_right = focusedWindow(function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
end)

resize_bot_left = focusedWindow(function(f, max)
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
end)

resize_bot_right = focusedWindow(function(f, max)
    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
end)

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

function setWallpaper(file)
    hs.osascript.applescript([[
    tell application "Finder"
    set desktop picture to POSIX file "]] .. file .. [["
end tell
]])
end

isBlurred = false

function blurred()
    local len = # hs.window.visibleWindows()
    if len <= 1 then
        if isBlurred then
            setWallpaper(os.getenv("HOME") .. "/Downloads/walls/FPyGCzs.jpg")
            isBlurred = false
        end
    else
        if not isBlurred then
            setWallpaper(os.getenv("HOME") .. "/Downloads/walls/blurred.png")
            isBlurred = true
        end
    end
end

blurred()

windows:subscribe(hs.window.filter.windowNotVisible, function () blurred() end)
windows:subscribe(hs.window.filter.windowVisible, function () blurred() end)

-- Key Bindings
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "g", toggle_gaps)
hs.hotkey.bind({"cmd", "ctrl"}, "f", fullscreen)
hs.hotkey.bind({"cmd", "alt"}, "f",  maximise)

-- Halves
hs.hotkey.bind({"cmd", "alt"}, "left", resize_left)
hs.hotkey.bind({"cmd", "alt"}, "right", resize_right)

-- Quarters
hs.hotkey.bind({"cmd", "control"}, "left", resize_top_left)
hs.hotkey.bind({"cmd", "control"}, "right", resize_top_right)
hs.hotkey.bind({"cmd", "control", "shift"}, "left", resize_bot_left)
hs.hotkey.bind({"cmd", "control", "shift"}, "right", resize_bot_right)

-- Focus
hs.hotkey.bind({"cmd", "ctrl"}, "h", focus_left)
hs.hotkey.bind({"cmd", "ctrl"}, "j", focus_bot)
hs.hotkey.bind({"cmd", "ctrl"}, "k", focus_top)
hs.hotkey.bind({"cmd", "ctrl"}, "l", focus_right)
