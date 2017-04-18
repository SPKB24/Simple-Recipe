#lang racket

(require "yummlyAPI.rkt")

(require net/url)
(require json)

(provide yummlySearch add-ingredients getRecipes)

;; Search api: http://api.yummly.com/v1/api/recipes?_app_id=app-id&_app_key=app-key&your _search_parameters
;;    Get api: http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY
(define yummlyID (string-append "?_app_id=" appID "&_app_key=" appKey))
(define yummlySearch (string-append "http://api.yummly.com/v1/api/recipes" yummlyID "&q="))

;; add-ingredients will take a list of strings to parse and add to the API call url
;;   ex. (add-ingredients (list "chicken" "eggs" "cheese"))
(define (add-ingredients items)
  (if (null? items)
      yummlySearch
      (begin
        (set! yummlySearch (string-append yummlySearch "&allowedIngredient[]=" (car items)))
        (add-ingredients (cdr items)))))

;; addToBlacklist will take a list of strings to parse and add to the API call url
;;   ex. (addToBlacklist (list "peanuts" "milk"))
(define (addToBlacklist items)
  (if (null? items)
      yummlySearch
      (begin
        (set! yummlySearch (string-append yummlySearch "&excludedIngredient[]=" (car items)))
        (addToBlacklist (cdr items)))))

;; Once all information has been added from the GUI to the yummlyURL, call this procedure
;; to actually send out the API call.
(define (getRecipes)
  (define in (get-pure-port (string->url yummlySearch)))
  (define response-string (port->string in))
  (close-input-port in)
  (getAllRecipes response-string))

;; Once we have a JSON response, this procedure will parse the results and give us
;; the information that we are looking for.
(define (getAllRecipes response)
  ;; This next line should get a list of recipes, need to loop through them like nobody's biznes
  (begin
    (define recipes (hash-ref (string->jsexpr response) 'matches))
    ;;(printf (jsexpr->string (car recipes)))
    (parseRecipes recipes 'sourceDisplayName '())))
  ;;(hash-ref (cadr recipes) 'sourceDisplayName))

;; This will parse a list of all recipes (10).
;;  - recipes: the json list of recipes recieved from getAllRecipes procedure
;;  - toSearch: a symbol that will parse the data that you want (ex. 'sourceDisplayName)
;;  - result: the resulting list with the data from each recipe, should be given empty list
;; ex. (parseRecipes recipes 'sourceDisplayName '())
(define (parseRecipes recipes toSearch result)
  (if (null? recipes)
      result
      (begin
        (set! result (append result (list (hash-ref (car recipes) toSearch))))
        (parseRecipes (cdr recipes) toSearch result))))

;; Mostly working, gets JSON
(define (getRecipeDetails recipeID)
  (let ([yummlyGet (string-append "http://api.yummly.com/v1/api/recipe/" recipeID yummlyID)])
    (define in (get-pure-port (string->url yummlyGet)))
    (define recipeInfo-string (port->string in))
    (close-input-port in)
    (string->jsexpr recipeInfo-string)))
