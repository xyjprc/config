;; change font size
(set-face-attribute 'default nil :height 140)

;; highlight indentation
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(add-hook 'js2-mode-hook 'highlight-indentation-mode)

;; spell checking
(setq-default ispell-program-name "C:/Program Files (x86)/Aspell/bin/aspell.exe")

(setq langtool-language-tool-jar "C:/Program Files (x86)/LanguageTool-3.1/languagetool-commandline.jar")
(setq langtool-default-language "en-US")

(setq text-mode-hook '(lambda()
                        ;(flyspell-mode nil)
                        ;(flycheck-mode nil)
                        ;(writegood-mode t)
                        (langtool-check-buffer)
                        (linum-mode)

                        ))

(global-set-key "\C-cw" 'writegood-mode)

(setq thesaurus-bhl-api-key "57d85a0f8abb36e90ad7663c94e32b2f")
;(require 'thesaurus)
(define-key global-map (kbd "C-x t") 'thesaurus-choose-synonym-and-replace)



;(require 'langtool)
;(setq langtool-language-tool-jar "C:/Program Files (x86)/LanguageTool-3.1/languagetool-commandline.jar")
;(setq langtool-default-language "en-US")
;(setq text-mode-hook '(lambda() (langtool-check-buffer) ))

;(require 'writegood-mode)
;(setq text-mode-hook '(lambda() (writegood-mode t) ))





;; start slime automatically when we open a lisp file
(defun prelude-start-slime ()
  (unless (slime-connected-p)
    (save-excursion (slime))))

;(setq slime-lisp-implementations '(("sbcl" ("C:/Program Files/Steel Bank Common Lisp/1.3.0/sbcl.exe" "--dynamic-space-size" "64000")) ("clisp" ("clisp")) ("ecl" ("ecl")) ("cmucl" ("cmucl"))))

(add-hook 'slime-mode-hook 'prelude-start-slime)

;(load "C:/quicklisp/slime-helper.el")
;; Replace "sbcl" with the path to your implementation
;(setq inferior-lisp-program "sbcl")

;(load "C:/Users/xyjpr/quicklisp/slime-helper.el")

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;(setq inferior-lisp-program "C:/Program Files/Steel Bank Common Lisp/1.3.0/sbcl.exe")


(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)
;(add-hook 'slime-mode-hook 'toggle-window-split)

(add-to-list 'exec-path "C:/Program Files/Steel Bank Common Lisp/1.3.0/sbcl.exe") ;; or wherever you installed SBCL or other Lisp

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;(setq inferior-lisp-program "C:/Program Files/Steel Bank Common Lisp/1.3.0/sbcl.exe")

(global-set-key (kbd "C-c \;") 'slime-selector)

;(setq inferior-lisp-program "sbcl") ;; or other Lisp

                                        ;(setq preview-image-type 'jpeg)
(setq doc-view-ghostscript-program "gswin64c.exe")

;(add-hook 'LaTeX-mode-hook 'writegood-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)

;(setq w32-get-true-file-attributes nil)

;(setq line-move-visual nil)
(add-hook 'LaTeX-mode-hook 'turn-off-auto-fill)
(setq prelude-whitespace nil)

;(add-hook 'LaTeX-mode-hook (lambda() (company-mode 0)))
;                             (flyspell-mode 0)))
(setq flycheck-global-modes '(not LaTeX-mode latex-mode))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)


(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(global-set-key (kbd "C-x b") 'switch-to-previous-buffer)


(require 'server)
(unless (server-running-p)
  (server-start))