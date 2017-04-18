#lang racket

(require browser)
(require racket/gui/base)
(require "yummlyCall.rkt")
(require racket/draw
         net/url)

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

(define (getstr str)
  (printf str))

;; http://stackoverflow.com/questions/16249705/get-the-selected-text-field-in-a-racket-gui
(define my-text-field%
  (class text-field%
    (super-new)
    (define/override (on-focus on?)
      (when on? (printf "~a\n" (send this get-label))))))

; Enter food likes here
(define recipe-food-items
  (new message%
       (parent frame)
       (label "What ingredients do you have?")
       (min-width 0)
       (vert-margin 8)
       (font (make-object font% 12 'default))))
(define field-likes (new my-text-field% [label ""] [parent frame] [min-width 100] [min-height 100]))

; Enter food dislikes here
(define recipe-food-dislike
  (new message%
       (parent frame)
       (label "What ingredients do you dislike?")
       (vert-margin 10)
       (min-width 0)
       (font (make-object font% 12 'default))))

(define field-dislikes (new my-text-field% [label ""] [parent frame] [min-width 100] [min-height 100]))
(define field-6 (new message% [label ""] [parent frame]))

;; http://stackoverflow.com/questions/36879265/how-to-align-racket-gui-text-fields-and-buttons
(define (callback button event)
  (define title-new-value (send field-likes get-value))
  (define userLikes (add-ingredients(regexp-split #px", " (string-append(send field-likes get-value)))))
  (define userDislikes (addToBlacklist(regexp-split #px", " (string-append(send field-dislikes get-value)))))

  (send recipe-name set-label yummlySearch)
  (send display-picture set-label logo))

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

(define blank (read-bitmap (get-pure-port (string->url "http://www.google.com"))))
(define logo (read-bitmap (get-pure-port (string->url "http://racket-lang.org/logo.png"))))

;; Picture of recipe here
(define display-picture
  (new message%
       (parent panel)
       (label blank)))

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

;; display the GUI
(send frame show #t)