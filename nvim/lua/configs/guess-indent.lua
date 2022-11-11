local status, guess_indent = pcall(require, "guess-indent")
if (not status) then return end

guess_indent.setup({})
