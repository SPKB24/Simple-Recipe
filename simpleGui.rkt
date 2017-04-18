#lang racket

(require browser)
(require racket/gui/base)
(require "yummlyCall.rkt")
(require racket/draw
         net/url)

(define pic (read-bitmap "macro_galaxy_by_zy0rg-360x240.jpg"))
(define pic2 (read-bitmap "wallcoverings-projects-border-360x240.jpg"))

(define frame (new frame% 
                  [label "Food Recipes"]
                  [width 700]
                  [height 1000]
                  ))

; Title
(define title
  (new message%
       (parent frame)
       (label "Welcome to Simple Recipe")
       (vert-margin 10)
       (min-width 0)
       (font (make-object font% 15 'default))))


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
; Enter food items here
(define recipe-food-items
  (new message%
       (parent frame)
       (label "What ingredients do you have?")
       (min-width 0)
       (vert-margin 8)
       (font (make-object font% 12 'default))))
(define field-1 (new my-text-field% [label ""] [parent frame] [min-width 100] [min-height 100]))
;(define field-2 (new my-text-field% [label "Food Item 2"] [parent frame]))
;(define field-3 (new my-text-field% [label "Food Item 3"] [parent frame]))
;(define field-4 (new my-text-field% [label "Food Item 4"] [parent frame]))
; Enter food items here
(define recipe-food-dislike
  (new message%
       (parent frame)
       (label "What ingredients do you dislike?")
       (vert-margin 10)
       (min-width 0)
       (font (make-object font% 12 'default))))
(define field-5 (new my-text-field% [label ""] [parent frame] [min-width 100] [min-height 100]))
(define field-6 (new message% [label ""] [parent frame]))

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

(define horizontal-line
  (new message%
       (parent frame)
       (label "------------------------------------------------------------------------------------------------------------------")
       (font (make-object font% 12 'default))))

(define panel
  (new vertical-panel%
       (parent frame)
       [style (list 'vscroll)]
       ))
  


; Recipe name here
(define recipe-name
  (new message%
       (parent panel)
       (vert-margin 10)
       (label "Recipe Name:")
       (min-width 0)
       (font (make-object font% 12 'default))))

; Required ingredients here
(define recipe-required
  (new message%
       (parent panel)
       (vert-margin 10)
       (label "Required ingredients:")
       (min-width 0)
       (font (make-object font% 12 'default))))

; Recipe picture here
(define recipe-picture
  (new message%
       (parent panel)
       (vert-margin 10)
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
       (vert-margin 10)
       (label "Nutritional facts:")
       (min-width 0)
       (font (make-object font% 12 'default))))

; Link to cooking instructions
(define recipe-instructions
  (new message%
       (parent panel)
       (vert-margin 10)
       (label "Instructions URL:")
       (min-width 0)
       (font (make-object font% 12 'default))))

(define logo (read-bitmap (get-pure-port (string->url "http://racket-lang.org/logo.png"))))
(define f (new message% [parent panel] [label "A picture"]))
(void (new message% [parent panel] [label logo]))

;; display the GUI
(send frame show #t)