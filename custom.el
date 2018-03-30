(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-clang-flags
   (quote
    ("-std=c++11" "-I/usr/include/c++/4.8" "-I/usr/include/x86_64-linux-gnu/c++/4.8" "-I/usr/include/c++/4.8/backward" "-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include" "-I/usr/local/include" "-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed" "-I/usr/include/x86_64-linux-gnu" "-I/usr/include")))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(beacon-color "#d54e53")
 '(company-backends
   (quote
    ((company-irony-c-headers company-irony)
     company-rtags company-bbdb company-nxml company-css company-eclim company-clang company-xcode company-cmake company-capf company-files
     (company-dabbrev-code company-gtags company-etags company-keywords)
     company-oddmuse company-dabbrev)))
 '(company-clang-arguments (quote ("-stdlib=libc++")))
 '(custom-enabled-themes (quote (tango)))
 '(custom-safe-themes
   (quote
    ("db08eb1e43f351490cfffd720db90600dd92d5cdf311f74350532ba71ae65c48" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(fci-rule-color "#424242")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(org-agenda-files
   (quote
    ("~/Library/Mobile Documents/com~apple~CloudDocs/Daily/2018年03月.org")))
 '(org-clock-idle-time nil)
 '(org-log-into-drawer t)
 '(package-selected-packages
   (quote
    (el-get  monokai-theme company-irony-c-headers company-irony cmake-ide clang-format company-rtags rtags irony ace-jump-helm-line ace-jump-mode toc-org orgit org-fstree auctex markdown-mode magit matlab-mode evil flex-isearch undo-tree switch-window page-break-lines whole-line-or-region expand-region hlinum autopair diminish help-fns+ tabbar default-text-scale auto-complete-clang ac-math pos-tip auto-complete popup fuzzy yasnippet smex ido-completing-read+ dired+ exec-path-from-shell)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "#e78c45")
     (60 . "#e7c547")
     (80 . "#b9ca4a")
     (100 . "#70c0b1")
     (120 . "#7aa6da")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "#e78c45")
     (200 . "#e7c547")
     (220 . "#b9ca4a")
     (240 . "#70c0b1")
     (260 . "#7aa6da")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "#e78c45")
     (340 . "#e7c547")
     (360 . "#b9ca4a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;(setq org-todo-keywords '((type "Fred" "Sara" "Lucy" "|" "DONE")))
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(defun fd-switch-dictionary()
      (interactive)
      (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
        (ispell-change-dictionary change)
        (message "Dictionary switched from %s to %s" dic change)
        ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary)


;; 按 Ctl-Enter 开始选中文本
(global-set-key (kbd "C-<return>") 'set-mark-command)


;; 启动 company 模式
(require 'company)
;;(add-hook 'after-init-hook 'global-company-mode)
(require 'rtags)
(require 'company-rtags)
(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

;; 设置快捷键
(define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-at-point))
(define-key c-mode-base-map (kbd "M-;") (function rtags-find-file))
(define-key c-mode-base-map (kbd "C-.") (function rtags-find-symbol))
(define-key c-mode-base-map (kbd "C-,") (function rtags-find-references))

;; 配置 irony 模式
(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(require 'company-irony)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))
(setq company-idle-delay              t
      company-minimum-prefix-length   2
      company-show-numbers            t
      company-tooltip-limit           20
      company-dabbrev-downcase        nil)
