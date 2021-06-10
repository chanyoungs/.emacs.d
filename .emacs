(let
    ((dir "C:/Users/chany/Programming/emacs"))
  (setenv "HOME" (file-name-as-directory dir))
  (setq user-init-file "C:/Users/chany/Programming/emacs/.emacs.d/init.el")
  (setq user-emacs-directory "C:/Users/chany/Programming/emacs/.emacs.d/")
  (setq default-directory "D:/Users/chany/Documents/")
  (load user-init-file))

;; Place this file in C:/Users/chany/ and point to the appropriate files
;;(setq user-init-file "C:/Users/chany/Documents/Programming/emacs/.emacs.d/init.el")
;;(setq user-emacs-directory "C:/Users/chany/Documents/Programming/emacs/.emacs.d/")
;;(setq default-directory "C:/Users/chany/Documents/Programming/")
;;(setenv "HOME" "C:/Users/chany/Documents/Programming/emacs/")
;;(load user-init-file)

;;(setq user-init-file "C:/emacs/.emacs.d/init.el")
;;(setq user-emacs-directory "C:/emacs/.emacs.d/")
;;(setq default-directory "C:/")
;;(setenv "HOME" "C:/emacs/")
;;(load user-init-file)