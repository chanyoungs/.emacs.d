(let
    (
     (*system* (system-name))
     (*emacs-directory*))
  (pcase *system*
    ("CYS-SP3" (progn
		 (setq *emacs-directory* "C:/Users/chany/Documents/Programming/emacs")
		 (setq default-directory "C:/Users/chany/Documents/Programming")
		 )
     )

    ("CYS-DesktopWindows" (progn
			    (setq *emacs-directory* "C:/Users/chany/Programming/emacs")
			    (setq default-directory "D:/Users/chany/Documents/Programming")
			    ))


    ("CYS-Ubuntu" (progn
		    (setq *emacs-directory* "/home/chanyoungs/Documents/Programming/emacs")
		    (setq default-directory "/home/chanyoungs/Documents/Programming")
		    ))

    
    (otherwise (format "'%s' requires a home directory to be set!" *system*))
    )
    (setenv "HOME" (file-name-as-directory *emacs-directory*))
  (setq user-init-file (expand-file-name "init.el" (expand-file-name ".emacs.d" *emacs-directory*  )))
  (setq user-emacs-directory (expand-file-name ".emacs.d" *emacs-directory*))
  (print (format "HOME: %s" (getenv "HOME")))
  (print (format "*system*: %s" *system*))
  (print (format "*emacs-directory*: %s" *emacs-directory*))
  (print (format "default-directory: %s" default-directory))
  (print (format "user-init-file: %s" user-init-file))
  (print (format "user-emacs-directory: %s" user-emacs-directory))
  )

