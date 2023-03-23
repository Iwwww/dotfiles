local status, colorizer = pcall(require, 'colorizer')
if (not status) then return end

colorizer.setup ({
    '*'; -- Highlight all files, but customize some others.
    css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
    html = { names = true; } -- Enable parsing "names" like Blue or Gray
}, { mode = 'background' })
