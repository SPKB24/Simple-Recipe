#lang racket

(require racket/gui/base)
(require "yummlyCall.rkt")

(define frame (new frame% 
                  [label "Food Recipes"]
                  [width 800]
                  [height 600]
                  ))

(define table (new list-box%
                 [parent frame]
                 [choices (list )]
                 [label "Food"]
                 [style (list 'single
                              'column-headers
                              'variable-columns)]
                 [columns (list "Food Item 1"
                                "Food Item 2"
                                "Food Item 3"
                                "Food Item 4"
                                "Recipe Generated"
                                "Link to Recipe")]))

(define data (list (list "egg" "chicken" "bacon" "apple")
                   (list "cheese" "garlic" "egg" "sugar")
                   (list "ham" "x" "english muffin" "ground cinnamon")
                   (list "x" "x" "x" "nutmeg")
                   (list "Ham and cheese omelet" "Grilled chicken breast" "Bacon and egg sandwhich" "Apple pie") ;; recipe
                   (list "http://www.food.com/recipe/ham-cheese-omelette-151744"
                         "http://www.onceuponachef.com/recipes/perfectly-grilled-chicken-breasts.html"
                         "http://www.food.com/recipe/bacon-and-egg-sandwich-56191"
                         "https://www.pillsbury.com/recipes/perfect-apple-pie/1fc2b60f-0a4f-441e-ad93-8bbd00fe5334"))) ;; url


(send table set (list-ref data 0) (list-ref data 1) (list-ref data 2) (list-ref data 3) (list-ref data 4)
      (list-ref data 5))

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
(define field-2 (new my-text-field% [label "Food Item 2"] [parent frame]))
(define field-3 (new my-text-field% [label "Food Item 3"] [parent frame]))
(define field-4 (new my-text-field% [label "Food Item 4"] [parent frame]))
(define field-5 (new my-text-field% [label "Recipe Link"] [parent frame]))

;; http://stackoverflow.com/questions/36879265/how-to-align-racket-gui-text-fields-and-buttons
(define (callback button event)
  (define title-new-value (send field-1 get-value))
  (define new-value (send field-2 get-value))
  (define userField1 (add-ingredients(list(string-append(send field-1 get-value)))))
  (define userField2 (add-ingredients(list(string-append(send field-2 get-value)))))
  (define userField3 (add-ingredients(list(string-append(send field-3 get-value)))))
  (define userField4 (add-ingredients(list(string-append(send field-4 get-value)))))
  (send field-1 set-value "")
  (send field-2 set-value "")
  (send field-3 set-value "")
  (send field-4 set-value "")
  (send field-5 set-value yummlyURL))
(define button
  (new button%
       [label "Submit"]
       [vert-margin 0]
       [horiz-margin 10]
       [parent frame] 
       [callback callback]))
;; display the GUI
(send frame show #t)