# Simple-Recipe

## Sohit Pal
### April 30, 2017

# Overview
Simple-Recipe gives users a quick and easy interface to finding recipes based on
the ingredients want to use or avoid.

Working with Michael Zurawski, we were able to create an simple, easy to use GUI
to access, parse, and display the most relevant information to the user, powered
by Yummly's online database of over 2 million recipes.

To use Simple-Recipe, simply enter comma-seperated ingedients into the two input
fields at the top of the GUI and click Submit. This will trigger a callback
function to call the Yummly API and display the data as needed.

**Authorship note:** All of the code described here was written by myself.

# Libraries Used
The code uses four libraries:

```
(require net/sendurl)
(require racket/gui/base)
(require net/url)
(require json)
```

* ```net/sendurl``` is a package that takes a url and opens it in the users
choice of browser. In our case, the we open the url to the recipe itself.
* ```racket/gui/base``` was used to create our GUI to connect with the user.
* ```net/url``` was used to make our API call to Yummly and to get the returned
data.
* ```json``` library was used to parse the returned data from the Yummly API call.

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from
UMass Lowell's COMP.3010 Organization of Programming languages course.

## 1. Creating creating Yummly API call URL

The following code creates creates the Yummly API call URL through appending multiple strings together.

```racket
(require "yummlyAPI.rkt")

;; Yummly API Search Format: http://api.yummly.com/v1/api/recipes?_app_id=app-id&_app_key=app-key&your_search_parameters
(define yummlyID (string-append "?_app_id=" appID "&_app_key=" appKey))
(define yummlySearch (string-append "http://api.yummly.com/v1/api/recipes" yummlyID))

;; add-ingredients will take a list of strings to parse and add to the API call url
;;   ex. (add-ingredients (list "chicken" "eggs" "cheese"))
(define (add-ingredients items)
  (if (null? items)
      yummlySearch
      (begin
        (when (not (or (null? (car items)) (equal? "" (car items))))
          (set! yummlySearch (string-append yummlySearch "&allowedIngredient[]=" (car items))))
        (add-ingredients (cdr items)))))
```

A couple of things are happening in the code above:
* Protecting my API Key
 * I wanted to keep my API key information safe, so I stored it in a seperate
 racket file called 'yummlyAPI.rkt'. I used the provide procedure to let me
 access the information in my yummlyCall.rkt file (which is where all of the
   backend code lives).
* Concatenating the url string with the additional API information
 * Once I have the API information stored in the yummlyID variable, I simply used
 string-append procedure to append "http://api.yummly.com/v1/api/recipes" to my
 API key information.
* Using add-ingredients procedure to append further information to the url
 * Finally, I want to add the ingredients to the url so that Yummly knows what
 kinds of recipes I am looking for. To accomplish this, I created the
 add-ingredients procedure.
 * add-ingredients takes a list of strings as a parameter. I chose this because
 it would be easy to get a list of strings from the GUI, and pass it here. Once
 received, it parses each, and adds each individual ingredient to the url.

These three things come together to give me a URL that I can pass to the net/url library to get the necessary information.

I used recursion in the add-ingredients procedure to add each item from the list
to the url.

## 2. Procedural Abstraction used to parse JSON response

```racket
(define (getRecipes)
  (define in (get-pure-port (string->url yummlySearch)))
  (define response-string (port->string in))
  (close-input-port in)
  (getAllMatches response-string))

(define (getAllMatches response)
  (begin
    (define recipes (hash-ref (string->jsexpr response) 'matches))
    (parseRecipes recipes 'sourceDisplayName '()))

(define (parseRecipes recipes toSearch result)
  (if (null? recipes)
      result
      (begin
        (set! result (append result (list (car recipes))))
        (parseRecipes (cdr recipes) toSearch result))))
```

The code above is used to call the Yummly API, get a responce, and then begin to
parse the response.

getRecipes calls the Yummly API and stores the response JSON string in a variable
named response-string. That string is then passed to getAllMatches, which will
begin to parse the JSON to get the "matches", which are the a list of the 10 best
recipes found by Yummly. That list is passed to parseRecipes, along with a
toSearch parameter, which will be used to _further_ parse the list.

Using abstraction like this, it becomes very easy for the developer to test the
code, and make changes as needed when developing. parseRecipes also displays a
usage of recursion to recurse through each of the recipes in the list.

## 3. Using Closure for efficiency

Calling a web API multiple times can come at the cost of efficiency (and in our
case, money because of a limited amount of calls allowed), so we wanted to assure
the minimum number of calls as possible.

```racket
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
       (define nutritionalInfo (hash-ref (string->jsexpr recipeDetails) 'nutritionEstimates))
       ;;(printf (jsexpr->string nutritionalInfo))
       (nutritionToString nutritionalInfo ""))]
    [(eq? attribute 'ingredients)
     (begin
       (define ingredients (hash-ref (string->jsexpr recipeDetails) 'ingredientLines))
       (ingredientsToString ingredients ""))]
    [(eq? attribute 'url)
     (hash-ref (hash-ref (string->jsexpr recipeDetails) 'source) 'sourceRecipeUrl)]
    [else (hash-ref (string->jsexpr recipeDetails) attribute)]))
```

Once I found the single recipe that I wanted to work with, I used set! to set a
variable to equal the JSON response. That way, I could create a procedure named
getRecipeAttribute, and simply pass an attribute variable such as 'image, or 'name
to get the desired information. Some huge benefits of this are overall efficiency,
simple code (to get the required data), and easily scalable.
