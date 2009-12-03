;;;; move pictures from pictures directory
;;; Time-stamp: <2005-01-18 19:04:55 jcgs>

;;  This program is free software; you can redistribute it and/or modify it
;;  under the terms of the GNU General Public License as published by the
;;  Free Software Foundation; either version 2 of the License, or (at your
;;  option) any later version.

;;  This program is distributed in the hope that it will be useful, but
;;  WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;  General Public License for more details.

;;  You should have received a copy of the GNU General Public License along
;;  with this program; if not, write to the Free Software Foundation, Inc.,
;;  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

(require 'webmaster-macros)

;;;###autoload
(defun move-picture (url)
  "Move URL"
  (message "move %s?" url)
  (cond

   ((and nil
	 (string-match "^c:/" url)
	 (string= default-directory (substring url 0 (length default-directory))))
    (let ((rel (substring url (length default-directory))))
      (message "Spotted abs file name %s, would like to make it %s" url rel)
      rel))

   ((and t
	 (string-match "/gifsmed/\\(.+\\)" url))
    (let* ((dest (expand-file-name(substring url (match-beginning 1) (match-end 1))))
	   (rel (substring dest (length default-directory)))
	   )
      (message "would like to move %s to %s (rel=%s)" url dest rel)
      (if (and (file-exists-p url)
	       (not (file-exists-p dest)))
	  (progn
	    (message "eligible to move" rel)
	    (rename-file url dest)
	    )
	(progn
	  (message "perhaps already moved")
	  ))
      rel))

   (t nil)))

(defun move-pictures (dir)
  "Move pictures within DIR."
  (interactive "DDirectory: ")
  (webmaster:apply-to-urls-throughout-tree
   dir t
   '(move-picture)))
