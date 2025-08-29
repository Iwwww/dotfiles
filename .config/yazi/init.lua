-- require("full-border"):setup({
-- 	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
-- 	type = ui.Border.PLAIN,
-- })
require("git"):setup()
if os.getenv("NVIM") then
	require("hide-preview"):entry()
end
require("session"):setup({
	sync_yanked = true,
})

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%m", time) == os.date("%m") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "", time)
end
