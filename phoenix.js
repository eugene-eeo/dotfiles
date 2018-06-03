/* jshint esversion: 6 */

PADDING = 5;

function windowResize(func) {
    return function() {
        var window = Window.focused();
        if (!window) {
            return;
        }
        var screen = Screen.main(),
            vFrame = screen.visibleFrame(),
            fvFrame = screen.flippedVisibleFrame();
        var frame = func(fvFrame);
        window.setFrame({
            // account for height of menubar and dock
            y:      frame.y + (fvFrame.y - vFrame.y) + PADDING,
            x:      frame.x + PADDING,
            width:  frame.w - 2 * PADDING,
            height: frame.h - 2 * PADDING,
        });
    };
}

var resize_left_half = windowResize(screen => ({
    x: 0,
    y: 0,
    w: screen.width / 2,
    h: screen.height,
}));

var resize_right_half = windowResize(screen => ({
    x: screen.width / 2,
    y: 0,
    w: screen.width / 2,
    h: screen.height,
}));

var resize_top_left_quarter = windowResize(screen => ({
    x: 0,
    y: 0,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var resize_top_right_quarter = windowResize(screen => ({
    x: screen.width / 2,
    y: 0,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var resize_bottom_left_quarter = windowResize(screen => ({
    x: 0,
    y: screen.height / 2,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var resize_bottom_right_quarter = windowResize(screen => ({
    x: screen.width / 2,
    y: screen.height / 2,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var maximise = windowResize(screen => ({
    x: 0,
    y: 0,
    w: screen.width,
    h: screen.height,
}));

function center_window() {
    var window = Window.focused();
    if (window) {
        var screen = window.screen(),
            sFrame = screen.frame(),
            wFrame = window.frame();
        window.setFrame({
            x:      sFrame.x + (sFrame.width / 2) - (wFrame.width / 2),
            y:      Math.max(0, sFrame.y) + (sFrame.height / 2) - (wFrame.height / 2),
            width:  wFrame.width,
            height: wFrame.height
        });
    }
}

function focus(direction) {
    return function() {
        var window = Window.focused();
        if (!window) return;
        for (var adj of window.neighbours(direction))
            if (adj.isVisible() && adj.focus())
                return;
    };
}

// Finally bind everything here
Key.on('left',  ['alt', 'ctrl'], focus('west'));
Key.on('right', ['alt', 'ctrl'], focus('east'));
Key.on('up',    ['alt', 'ctrl'], focus('north'));
Key.on('down',  ['alt', 'ctrl'], focus('south'));

Key.on('x', ['cmd', 'alt'], center_window);
Key.on('f', ['cmd', 'alt'], maximise);

Key.on('left',  ['cmd', 'ctrl'], resize_left_half);
Key.on('right', ['cmd', 'ctrl'], resize_right_half);

Key.on('left',  ['cmd', 'alt'], resize_top_left_quarter);
Key.on('right', ['cmd', 'alt'], resize_top_right_quarter);
Key.on('left',  ['cmd', 'alt', 'shift'], resize_bottom_left_quarter);
Key.on('right', ['cmd', 'alt', 'shift'], resize_bottom_right_quarter);
