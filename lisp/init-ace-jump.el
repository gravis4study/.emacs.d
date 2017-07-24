 (add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
    (require 'ace-jump-mode)
    (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
    ;;If you also use viper mode:
 ;; (define-key viper-vi-global-user-map (kbd "SPC") 'ace-jump-mode)

(provide 'init-ac-source)

