;; 19aug18 DJS elisp func to "fill line"
;; Given a line of text, this func:
;; 1. clips everything before the first space and after the last
;; 2. Pads on left and right w/ padding char, so line is total of 80 chars long.
;; Handy e.g. for inserting comment lines in source code that span the page.

(defun fillline (pad)
  "fillline doc.  One arg: pad = string char to pad with."
  (interactive "spad:")    ; so can call with M-x; pad read from minibuffer
  
  ;;;; First remove all text from start to first space, but space still there
  (move-beginning-of-line nil)
  (setq beg (point))                  ; like C-space, but don't use set-mark-*
  (search-forward " ")                ; point now just after first space on line
  (delete-region beg (- (point) 1))   ; delete current region, don't put in kill ring
  
  ;;;; Now remove all text from end to last space, but space still there
  (move-end-of-line nil)
  (setq beg (point))
  (search-backward " ")               ; point now just after first space on line
  (delete-region beg (+ (point) 1))   ; delete current region, don't put in kill ring

  ;;;; determine padding
  (setq textLen (+ 1 (current-column)))    ; total amount of text in line - including 1st+last spaces
  ;; (message "textLen is:")
  ;; (message "%s" textLen)
  (setq padLeft (/ (- 80 textLen) 2))      ; number of * to pad on left
  (setq padRight (- 80 padLeft textLen))   ; * on right

  ;; pad left
  (setq pad_asc (string-to-char pad))   ; ascii for pad character
  (move-beginning-of-line nil)
  (insert (make-string padLeft pad_asc))
  ;; pad right
  (move-end-of-line nil)
  (insert (make-string padRight pad_asc))
)
