#lang racket

(require browser)
(require racket/gui/base)
(require "yummlyCall.rkt")
(require racket/draw
         net/url)
(require net/sendurl)

(define blank (read-bitmap (get-pure-port (string->url "http://hipsterhub.com/wp-content/uploads/2011/05/blue-pattern-ipad-wallpaper-300x300.jpg"))))
(define logo (read-bitmap (get-pure-port (string->url "http://racket-lang.org/logo.png"))))

(define frame (new frame%
                  [label "Simple Recipe"]
                  [width 850]
                  [height 1000]
                  ))

; Title
(define title
  (new message%
       (parent frame)
       (label "Welcome to Simple Recipe")
       (vert-margin 10)
       (min-width 0)
       (font (make-object font% 18 'default))))

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
(define field-likes (new text-field% [label ""] [parent frame] [min-width 60] [min-height 60]))

; Enter food dislikes here
(define recipe-food-dislike
  (new message%
       (parent frame)
       (label "What ingredients do you dislike?")
       (vert-margin 10)
       (min-width 0)
       (font (make-object font% 12 'default))))

(define field-dislikes (new text-field% [label ""] [parent frame] [min-width 60] [min-height 60]))
(define field-6 (new message% [label ""] [parent frame]))

(define (callback button event)
  (define title-new-value (send field-likes get-value))
  (when (not (equal? (car (regexp-split #px", " (string-append(send field-likes get-value)))) ""))
      (add-ingredients(regexp-split #px", " (string-append(send field-likes get-value)))))
  (when (not (equal? (car (regexp-split #px", " (string-append(send field-dislikes get-value)))) ""))
      (addToBlacklist(regexp-split #px", " (string-append(send field-dislikes get-value)))))

  (getRecipes)

  ;(printf yummlySearch)
  ;(printf "\n")
  (printf (number->string counter))
  (printf "\n")
  (printf (getRecipeAttribute 'ingredients))
  (printf "\n")
  (printf (getRecipeAttribute 'image))
  (printf "\n")

  ;(printf (getRecipeAttribute 'recipeName)))
  (send recipe-name set-label (getRecipeAttribute 'name))
  (send display-picture set-label (read-bitmap (get-pure-port (string->url (getRecipeAttribute 'image)))))
  (send field-ingredients set-value (getRecipeAttribute 'ingredients))
  (send field-nutritional-facts set-value (getRecipeAttribute 'nutrition))

  (iterateCounter)
  (reset-yummly)
  (printf "Done\n"))



(define button
  (new button%
       [label "Submit"]
       [vert-margin 6]
       [horiz-margin 0]
       [parent frame]
       [callback callback]))

;(define horizontal-line
;  (new message%
;       (parent frame)
;       (label "------------------------------------------------------------------------------------------------------------------")
;       (font (make-object font% 12 'default))))

(define main-panel
  (new vertical-panel%
       (parent frame)
       (alignment (list 'left 'top))
       [style (list 'vscroll 'border)]
       (min-height 10)
       ))

(define horizontal-display-panel
  (new horizontal-panel%
       (parent main-panel)
       (alignment (list 'left 'top))
       ;[style (list 'vscroll 'border)]
       (min-height 10)
       [stretchable-height #f]
       ))

(define display-picture
  (new message%
       (parent horizontal-display-panel)
       (min-height 100)
       (min-width 200)
       (vert-margin 10)
       (label logo)))

(define recipe-name
  (new message%
       (parent horizontal-display-panel)
       (label "Recipe")
       (min-width 500)
       (vert-margin 10)
       (font (make-object font% 15 'default))))


(define panel
  (new vertical-panel%
       (parent main-panel)
       (alignment (list 'left 'center))
       ;[style (list 'vscroll)]
       ))

; Recipe name here
;(define recipe-name
;  (new message%
;       (parent panel)
;       (vert-margin 10)
;       (label "Recipe Name:")
;       (min-width 0)
;       (font (make-object font% 12 'default))))

; Required ingredients here
(define recipe-required
  (new message%
       (parent panel)
       (vert-margin 10)
       (label "Required ingredients")
       (horiz-margin 10)
       (min-width 0)
       (font (make-object font% 12 'default))))

(define field-ingredients (new text-field% [label ""] [parent panel] [min-width 100] [min-height 100]))

; Recipe picture here
;(define recipe-picture
;  (new message%
;       (parent panel)
;       (vert-margin 10)
;       (label "Sample picture:")
;       (min-width 0)
;       (font (make-object font% 12 'default))))



;; Picture of recipe here
;(define display-picture
;  (new message%
;       (parent panel)
;       (label blank)))

; Nutritional facts here
(define recipe-macros
  (new message%
       (parent panel)
       (vert-margin 10)
       (label "Nutritional facts")
       (horiz-margin 10)
       (min-width 0)
       (font (make-object font% 12 'default))))

(define field-nutritional-facts (new text-field% [label ""] [parent panel] [min-width 100] [min-height 100]))

; Link to cooking instructions
(define recipe-instructions
  (new message%
       (parent panel)
       (vert-margin 10)
       (label "Instructions link")
       (horiz-margin 10)
       (min-width 0)
       (font (make-object font% 12 'default))))

(define field-url (new text-field% [label ""] [parent panel]))

(define (url-callback button event)
  (define new-url (send field-url get-value))
  (send-url new-url))

(define url-button
  (new button%
       [label "Open"]
       [parent panel]
       (horiz-margin 425)
       [callback url-callback]))


;; display the GUI
(send frame show #t)
