#lang racket

(require "yummlyAPI.rkt")

(require net/url)
(require json)

(provide yummlySearch
         counter
         reset-yummly
         add-ingredients
         addToBlacklist
         getRecipes
         getRecipeAttribute
         iterateCounter)

;; Search api: http://api.yummly.com/v1/api/recipes?_app_id=app-id&_app_key=app-key&your _search_parameters
;;    Get api: http://api.yummly.com/v1/api/recipe/recipe-id?_app_id=YOUR_ID&_app_key=YOUR_APP_KEY
(define yummlyID (string-append "?_app_id=" appID "&_app_key=" appKey))
(define yummlySearch (string-append "http://api.yummly.com/v1/api/recipes" yummlyID))
(define counter 1)
(define recipeDetails "")

(define (reset-yummly)
  (set! yummlySearch (string-append "http://api.yummly.com/v1/api/recipes" yummlyID)))

(define (iterateCounter)
  (if (= counter 10)
      (set! counter 1)
      (set! counter (+ counter 1))))

;; add-ingredients will take a list of strings to parse and add to the API call url
;;   ex. (add-ingredients (list "chicken" "eggs" "cheese"))
(define (add-ingredients items)
  (if (null? items)
      yummlySearch
      (begin
        (when (not (or (null? (car items)) (equal? "" (car items))))
          (set! yummlySearch (string-append yummlySearch "&allowedIngredient[]=" (car items))))
        (add-ingredients (cdr items)))))

;; addToBlacklist will take a list of strings to parse and add to the API call url
;;   ex. (addToBlacklist (list "peanuts" "milk"))
(define (addToBlacklist items)
  (if (null? items)
      yummlySearch
      (begin
        (when (not (and (null? (car items)) (equal? "" (car items))))
          (set! yummlySearch (string-append yummlySearch "&excludedIngredient[]=" (car items))))
        (addToBlacklist (cdr items)))))

;; Once all information has been added from the GUI to the yummlyURL, call this procedure
;; to actually send out the API call.
(define (getRecipes)
  (define in (get-pure-port (string->url yummlySearch)))
  (define response-string (port->string in))
  (close-input-port in)
  (getAllMatches response-string))

;; Once we have a JSON response, this procedure will parse the results and give us
;; the information that we are looking for.
(define (getAllMatches response)
  ;; This next line should get a list of recipes, need to loop through them like nobody's biznes
  (begin
    (define recipes (hash-ref (string->jsexpr response) 'matches))
    ;;(printf (jsexpr->string (car recipes)))
    ;;(parseRecipes recipes 'id '())))
    (getSingleRecipe recipes 1)))
  ;;(hash-ref (cadr recipes) 'sourceDisplayName))

(define (getSingleRecipe recipes current)
  (if (= counter current)
      ;; Do something with the recipe (in (car recipes))
      (getRecipeDetails (hash-ref (car recipes) 'id))
      (if (null? (cdr recipes))
          (getSingleRecipe recipes (counter))
          (getSingleRecipe (cdr recipes) (+ current 1)))))

;; This will parse a list of all recipes (10).
;;  - recipes: the json list of recipes recieved from getAllMatches procedure
;;  - toSearch: a symbol that will parse the data that you want (ex. 'sourceDisplayName)
;;  - result: the resulting list with the data from each recipe, should be given empty list
;; ex. (parseRecipes recipes 'sourceDisplayName '())
(define (parseRecipes recipes toSearch result)
  (if (null? recipes)
      result
      (begin
        (set! result (append result (list (car recipes))))
        (parseRecipes (cdr recipes) toSearch result))))

;; Mostly working, gets JSON
(define (getRecipeDetails recipeID)
  (let ([yummlyGet (string-append "http://api.yummly.com/v1/api/recipe/" recipeID yummlyID)])
    (define in (get-pure-port (string->url yummlyGet)))
    (set! recipeDetails (port->string in))
    (close-input-port in)))

(define (getRecipeAttribute attribute)
  (cond
    [(eq? attribute 'image)
     (begin
       (define images (hash-ref (string->jsexpr recipeDetails) 'images))
       (getImage images))]
    [(eq? attribute 'nutrition)
     (begin
       "theNutrition")]
    [(eq? attribute 'ingredients)
     (begin
       (define ingredients (hash-ref (string->jsexpr recipeDetails) 'ingredientLines))
       (ingredientsToString ingredients ""))]
    [else (hash-ref (string->jsexpr recipeDetails) attribute)]))

(define (ingredientsToString ingredientsList stringToReturn)
  (if (null? ingredientsList)
      stringToReturn
      (if (null? (cdr ingredientsList))
          (ingredientsToString
           (cdr ingredientsList)
           (string-append stringToReturn (car ingredientsList)))
          (ingredientsToString
           (cdr ingredientsList)
           (string-append stringToReturn (car ingredientsList) "\n")))))

(define (getImage imageListJson)
  (hash-ref (car imageListJson) 'hostedMediumUrl))
























      