PADDING = 5;

function windowResize(func) {
    return function() {
        var window = Window.focused();
        if (!window) {
            return;
        }
        var screen = Screen.main();
        var vf = screen.flippedVisibleFrame();
        var fr = screen.visibleFrame();
        var frame = func(window.frame(), vf);
        // takes menubar and dock into account
        frame.y += (vf.y - fr.y) + PADDING; 
        frame.x += PADDING;
        frame.w -= 2 * PADDING;
        frame.h -= 2 * PADDING;
        window.setFrame({
            x: frame.x,
            y: frame.y,
            width: frame.w,
            height: frame.h,
        });
    };
}

var resize_left_half = windowResize((_, screen) => ({
    x: 0,
    y: 0,
    w: screen.width / 2,
    h: screen.height,
}));

var resize_right_half = windowResize((_, screen) => ({
    x: screen.width / 2,
    y: 0,
    w: screen.width / 2,
    h: screen.height,
}));

var resize_top_left_quarter = windowResize((_, screen) => ({
    x: 0,
    y: 0,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var resize_top_right_quarter = windowResize((_, screen) => ({
    x: screen.width / 2,
    y: 0,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var resize_bottom_left_quarter = windowResize((_, screen) => ({
    x: 0,
    y: screen.height / 2,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var resize_bottom_right_quarter = windowResize((_, screen) => ({
    x: screen.width / 2,
    y: screen.height / 2,
    w: screen.width / 2,
    h: screen.height / 2,
}));

var fullscreen_toggle = function() {
    var window = Window.focuseded();
    if (window) {
        window.setFullScreen(!window.isFullScreen());
    }
};

var maximise = function() {
    var window = Window.focused();
    if (window) {
        window.maximise();
    }
};

function focusClosest(direction) {
    return function() {
        var window = Window.focused();
        if (!window) {
            return
        }
        //window.focusClosestNeighbour(direction);
        var neighbours = window.neighbours(direction);
        for (adj of neighbours) {
            if (adj.isVisible()) {
                adj.focus();
                return;
            }
        }
    };
}

// Finally bind everything here
Key.on('left',  ['alt', 'ctrl'], focusClosest('west'));
Key.on('right', ['alt', 'ctrl'], focusClosest('east'));
Key.on('up',    ['alt', 'ctrl'], focusClosest('north'));
Key.on('down',  ['alt', 'ctrl'], focusClosest('south'));

Key.on('f', ['cmd', 'alt'], maximise);
Key.on('f', ['cmd', 'ctrl'], fullscreen_toggle);

Key.on('left',  ['cmd', 'ctrl'], resize_left_half);
Key.on('right', ['cmd', 'ctrl'], resize_right_half);

Key.on('left',  ['cmd', 'alt'], resize_top_left_quarter);
Key.on('right', ['cmd', 'alt'], resize_top_right_quarter);
Key.on('left',  ['cmd', 'alt', 'shift'], resize_bottom_left_quarter);
Key.on('right', ['cmd', 'alt', 'shift'], resize_bottom_right_quarter);
