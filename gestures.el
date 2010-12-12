;;; gestures.el --- configuration for strokes-mode with a touchscreen

;; Copyright (C) 2010  David O'Toole

;; Author: David O'Toole <dto@gnu.org>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Here is my preliminary configuration and stroke library for using
;; Emacs with a touchscreen. See strokes.el in Emacs for details on
;; the recognition. 

;; See this video for a demo of the gestures:
;; http://www.youtube.com/watch?v=lw8SQqmHPbI

;; The gestures are in gesture-library.el. Strokes-mode will read
;; gestures to / write gestures from ~/.strokes by default; I use the
;; folowing settings:

;; (setq strokes-file "~/emacs-gestures/gesture-library.el")

;; Once you tell Strokes where gesture-library.el is, do this: 

;; (gestures-setup)

;; Unfortunately some of the gestures in the file map to functions
;; that are specific to my setup, but the main ones should work. 

;; TODO allow a standard gestures library plus a user-local file to be used
;; TODO Draw the gestures for the user so they know what to draw?
;; TODO find out why strokes-mode sometimes obliterate random buffers (!!)
;; TODO fix mouse behavior and requiring mouse-3 to finish defining stroke
;; TODO why strokes-mode and desktop-mode are a bad combo?
;; TODO define more gestures as a community effort to gesture-enable emacs
;; TODO probably standardize on larger than 9x9 grid---redo gestures :(

;;; Code:

(require 'strokes)

;; This wrapper function sort of fixes strokes' not being designed for
;; a touchscreen.

(defun my-strokes-do-stroke (event)
  (interactive "e")
  (or strokes-mode (strokes-mode t))
  (let ((stroke (strokes-read-stroke nil event)))
    (if (< (length stroke) 3)
	(mouse-set-point event)
	(strokes-execute-stroke stroke))))

;; Now tell strokes about the function.

(defun gestures-setup ()
  (interactive)
  (setf strokes-use-strokes-buffer nil)  ;; Recommended!
  (global-set-key [(down-mouse-1)] 'my-strokes-do-stroke))

;;; Extra defun wrappers 

(defun gestures-next-window ()
  (interactive)
  (other-window 1))

(defun gestures-previous-window ()
  (interactive)
  (other-window -1))

(defun gestures-ret () (interactive) (call-interactively (key-binding (kbd
  "RET"))))

(defun gestures-help () (interactive) (call-interactively (info-ansicl)))

(defun gestures-rotate-portrait () (interactive) (shell-command
  "/home/dto/bin/rotate-portrait.sh"))

(defun gestures-rotate-laptop () (interactive) (shell-command
  "/home/dto/bin/rotate-laptop.sh"))

(defun gestures-rotate-tablet () (interactive) (shell-command
  "/home/dto/bin/rotate-tablet.sh"))


(provide 'gestures)
;;; gestures.el ends here

