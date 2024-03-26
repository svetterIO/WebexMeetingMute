#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 3


; mute function
^!m::

	; set current_ID to foreground window if needed
	current_ID := webexCheck()

	; if webex windows was found
	if current_ID
		; send ALT-p and m to mute the participant
		Send !pm
		; restore previously active window if needed
		WinActivate ahk_id %current_ID%

		; set muted indicator icon in tray
		Menu, Tray, Icon, webexMeetingMute-muted.ico
		
return


; unmute function
^!u::

	; set current_ID to foreground window if needed
	current_ID := webexCheck()

	; if webex windows was found
	if current_ID
		; send ALT-p and u to unmute the participant
		Send !pu
		; restore previously active window if needed
		WinActivate ahk_id %current_ID%

		; set muted indicator icon in tray
		Menu, Tray, Icon, webexMeetingMute-unmuted.ico

return


webexCheck() {
	; check to see if Meetings is the active window or not
	win_ID = 
	if WinExist("Webex")
	{
		; grab the current active window
		WinGet, win_ID, ID, A
		; flip Meetings to the foreground, silently fail if Meetings does not surface
		WinActivate, Webex
		WinWaitActive Webex,, 1
		if ErrorLevel = 1
			return
	}
	return win_ID
}