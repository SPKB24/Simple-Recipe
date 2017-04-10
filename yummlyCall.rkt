#lang racket

(require "yummlyAPI.rkt")

(require net/url)
(require json)

(provide yummlyURL add-ingredients getRecipes)

(define yummlyURL (string-append "http://api.yummly.com/v1/api/recipes?_app_id=" appID "&_app_key=" appKey "&q="))

;; add-ingredients will take a list of strings to parse and add to the API call url
;;   ex. (add-ingredients (list "chicken" "eggs" "cheese"))
(define (add-ingredients ingredients)
  (if (null? ingredients)
      yummlyURL
      (begin
        (if (null? (cdr ingredients))
            (set! yummlyURL (string-append yummlyURL (car ingredients)))
            (set! yummlyURL (string-append yummlyURL (car ingredients) "+")))
        (add-ingredients (cdr ingredients)))))

;; addToBlacklist will take a list of strings to parse and add to the API call url
;;   ex. (addToBlacklist (list "peanuts" "milk"))
(define (addToBlacklist items)
  (if (null? items)
      yummlyURL
      (begin
        (if (null? (cdr items))
            (set! yummlyURL (string-append yummlyURL (car items)))
            (set! yummlyURL (string-append yummlyURL (car items) "+")))
        (addToBlacklist (cdr items)))))

;; Once all information has been added from the GUI to the yummlyURL, call this procedure
;; to actually send out the API call.
(define (getRecipes)
  (define in
    (get-pure-port
     (string->url yummlyURL)))
  (define response-string (port->string in))
  (close-input-port in)
  (getRecipesList response-string))

;; Once we have a JSON response, this procedure will parse the results and give us
;; the information that we are looking for.
(define (getRecipesList response)
  ;; This next line should get a list of recipes, need to loop through them like nobody's biznes
  (begin
    (define recipes (hash-ref (string->jsexpr response) 'matches))
    (printf (jsexpr->string recipes))
    (hash-ref (cadr recipes) 'sourceDisplayName)))

(define (parseRecipes recipes)
  (if (null? recipes)
      '()
      (begin
        (hash-ref (string->jsexpr (car recipes)) 'sourceDisplayName)
        (parseRecipes (cdr recipes)))))
