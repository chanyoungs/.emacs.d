#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

GroupAdd, winTest, ahk_class Emacs
GroupAdd, winTest, ahk_class Chrome_WidgetWin_1
GroupAdd, winTest, ahk_class MozillaWindowClass
GroupAdd, winTest, ahk_class PuTTY
return

;F12::
;   WinGetClass, Title, A
;   MsgBox, The active window is "%Title%".
;return

;ActiveHwnd := WinExist("A") ; to assign Active windo id to 'ActiveHwnd' use... ActiveHwnd := WinExist("A")
;MsgBox, The active window is "%ActiveHwnd%" ; to print a message box use... MsgBox, The active window is "%ActiveHwnd%".

#IfWinNotExist ahk_class Emacs
{
^!e::
;Run C:\Users\chany\Documents\Programming\emacs\emacs-25.2-x86_64\bin\emacsclientw.exe -a "" -c, , Max
Run C:\Users\chany\Documents\Programming\emacs\emacs-25.2-x86_64\bin\emacsclientw.exe --server-file="C:\Users\chany\Documents\Programming\emacs\.emacs.d\server\server" -a "" -c, , Max
return
}

#IfWinExist ahk_class Emacs
{
	#IfWinNotActive ahk_class Emacs
	{
		^!e::
		{	
			WinActivate, ahk_class Emacs
			return
		}
	}
	#IfWinActive ahk_class Emacs
	{
		^!e::
		{
			;Run C:\Users\chany\Documents\Programming\emacs\emacs-25.2-x86_64\bin\emacsclientw.exe -a "" -c, , Max
			;return
			Run C:\Users\chany\Documents\Programming\emacs\emacs-25.2-x86_64\bin\emacsclientw.exe --server-file="C:\Users\chany\Documents\Programming\emacs\.emacs.d\server\server" -a "" -c, , Max
			return
		}
	}
}



#IfWinActive ahk_group winTest
;Capslock::Capslock ; make shift+Caps-Lock the Caps Lock toggle
Capslock::Control   ; make Caps Lock the control button
return
#IfWinActive        ; end if not in group