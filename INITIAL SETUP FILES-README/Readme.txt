---[.emacs]----
You need to make a hard symlink of .emacs at where emacs initially thinks is the Home directory(In windows, "C:\Users\chany\AppData\Roaming")

Open cmd as admin then:
***
mklink <destination file> <source file>
***

If the system name is not defined in the .emacs file, add the system name and the relevant paths in the .emacs file.

---[emacs-daemon_shortcut.exe]---
Check the shortcut path in the shortcut file, copy and modify if required and put it in the start-up folder

---[emacsclientw_shortcut]---
This file can be used to open emacs. It will open a daemon if non existent, and will open a client