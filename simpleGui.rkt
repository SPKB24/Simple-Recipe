#lang racket

(require browser)
(require racket/gui/base)
(require "yummlyCall.rkt")

(define pic (read-bitmap "macro_galaxy_by_zy0rg-360x240.jpg"))
(define pic2 (read-bitmap "wallcoverings-projects-border-360x240.jpg"))

(define frame (new frame% 
                  [label "Food Recipes"]
                  [width 700]
                  [height 1000]
                  ))
(define panel
  (new vertical-panel%
       (parent frame)
       [style (list 'vscroll)]
       ))
  
; Title
(define title
  (new message%
       (parent panel)
       (label "Welcome to Simple Recipe")
       (min-width 0)
       (font (make-object font% 15 'default))))

; Recipe name here
(define recipe-name
  (new message%
       (parent panel)
       (vert-margin 50)
       (label "Recipe Name:")
       (min-width 0)
       (font (make-object font% 12 'default))))

; Required ingredients here
(define recipe-required
  (new message%
       (parent panel)
       (vert-margin 50)
       (label "Required ingredients:")
       (min-width 0)
       (font (make-object font% 12 'default))))

; Recipe picture here
(define recipe-picture
  (new message%
       (parent panel)
       (vert-margin 50)
       (label "Sample picture:")
       (min-width 0)
       (font (make-object font% 12 'default))))

(define display-picture
  (new message%
       (parent panel)
       (label pic)))

; Nutritional facts here
(define recipe-macros
  (new message%
       (parent panel)
       (vert-margin 50)
       (label "Nutritional facts:")
       (min-width 0)
       (font (make-object font% 12 'default))))

; Link to cooking instructions
(define recipe-instructions
  (new message%
       (parent panel)
       (vert-margin 50)
       (label "Instructions URL:")
       (min-width 0)
       (font (make-object font% 12 'default))))



;(define castle-button
 ; (new button%
  ;     (parent pane1l)
   ;    (label "Castle")))

(define (getstr str)
  (printf str))

;; http://stackoverflow.com/questions/16249705/get-the-selected-text-field-in-a-racket-gui
(define my-text-field%
  (class text-field%
    (super-new)
    (define/override (on-focus on?)
      (when on? (printf "~a\n" (send this get-label))))))

;;(define frame (new frame% [label "Frame"]))
(define field-1 (new my-text-field% [label "Food Item 1"] [parent frame]))
;(define field-2 (new my-text-field% [label "Food Item 2"] [parent frame]))
;(define field-3 (new my-text-field% [label "Food Item 3"] [parent frame]))
;(define field-4 (new my-text-field% [label "Food Item 4"] [parent frame]))
(define field-5 (new my-text-field% [label "Recipe Link"] [parent frame]))
(define field-6 (new message% [label "Recipe Link"] [parent frame]))

;; http://stackoverflow.com/questions/36879265/how-to-align-racket-gui-text-fields-and-buttons
(define (callback button event)
  (define title-new-value (send field-1 get-value))
  ;(define new-value (send field-2 get-value))
  (define userField1 (add-ingredients(list(string-append(send field-1 get-value)))))
  ;(define userField2 (add-ingredients(list(string-append(send field-2 get-value)))))
  ;(define userField3 (add-ingredients(list(string-append(send field-3 get-value)))))
  ;(define userField4 (add-ingredients(list(string-append(send field-4 get-value)))))
  ;(send field-1 set-value "")
  ;(send field-2 set-value "")
  ;(send field-3 set-value "")
  ;(send field-4 set-value "")
  (send field-5 set-value yummlySearch)
  (send display-picture set-label pic2))
(define button
  (new button%
       [label "Submit"]
       [vert-margin 0]
       [horiz-margin 10]
       [parent frame] 
       [callback callback]))
;; display the GUI
(send frame show #t)