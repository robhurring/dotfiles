-- Show/hide any app: bring to front if not frontmost, hide if it already is.
-- Usage: osascript toggle-window.applescript "<App Name>" ["<Process Name>"]
--   App Name     - name used to launch/activate (e.g. "Google Chrome")
--   Process Name - optional, name as it appears in System Events processes
--                  (defaults to App Name; needed when they differ, e.g.
--                   app "Ghostty" runs as process "ghostty")
on run argv
	if (count of argv) < 1 then error "usage: toggle-window.applescript <App Name> [Process Name]"
	set appName to item 1 of argv
	if (count of argv) ≥ 2 then
		set procName to item 2 of argv
	else
		set procName to appName
	end if

	tell application "System Events"
		set isRunning to (exists (processes whose name is procName))
		if not isRunning then
			tell application appName to activate
		else
			set isFront to (name of first process whose frontmost is true) is procName
			if isFront then
				set visible of process procName to false
			else
				-- un-hide + raise. `activate` alone is unreliable from a background
				-- context, so drive it through System Events instead.
				tell process procName
					set visible to true
					set frontmost to true
				end tell
			end if
		end if
	end tell
end run
