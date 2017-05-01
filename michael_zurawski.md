# Simple-Recipe

## Mike Zurawski
## April 30, 2016

# Overview
Our project allows the user to input basic food items they have around and have a recipe generated out of those ingredients. The recipe is random each time with a link provided to the recipe. For the most part Sohit did backend with a little frontend and I did frontend with a little backend.

# Libraries Used
```
(require racket/gui/base)
(require net/url)
(require net/sendurl)
(require json)
```
- Racket GUI library. Used to create a clean, simple UI to display information to users.
- The net/url library allows us to display images from the web in our GUI.
- The net/sendurl library allows us to use our default browser to display origin of the recipe's website.
- Racket JSON library. Used to parse the JSON responses from Yummly API Calls.


# Key Code Excerpts

## 1. Creating a class
This bit of code is simply creating a new class message which will be used for the title.
The code is rather simple but sort of sums up how to use racket GUI.
```
(define title
  (new message%
       (parent frame)
       (label "Welcome to Simple Recipe")
       (vert-margin 10)
       (min-width 0)
       (font (make-object font% 18 'default))))
```

## 2. Using Regex
Before the project started I was unaware racket supported regex. Using regex in this project proved to be quite helpful. 

Here we used regex to remove the commas from a string. This string comes from the user input field where the user enters food items seperated by commas(cheese, chicken, banana...). Removing the commas makes dealing with the list 'add-ingredients' creates easier for everyone.

```
(define (callback button event)
  (define title-new-value (send field-likes get-value))
  (when (not (equal? (car (regexp-split #px", " (string-append(send field-likes get-value)))) ""))
      (add-ingredients(regexp-split #px", " (string-append(send field-likes get-value)))))
```

## 3. Callback procedure
The main star of the 'simpleGUI.rkt' file is the callback procedure. When the user is finished inputting thier food items and the submit button is clicked, the 'callback' procedure gets called. The procedure's purpose is to take in the information the user input, process it using procedure's from 'yummlyCall.rkt', and then display the results all in one click. 

```
(define (callback button event)
  (define title-new-value (send field-likes get-value))
  (when (not (equal? (car (regexp-split #px", " (string-append(send field-likes get-value)))) ""))
      (add-ingredients(regexp-split #px", " (string-append(send field-likes get-value)))))
  (when (not (equal? (car (regexp-split #px", " (string-append(send field-dislikes get-value)))) ""))
      (addToBlacklist(regexp-split #px", " (string-append(send field-dislikes get-value)))))
  (getRecipes)
  ;(printf (getRecipeAttribute 'recipeName)))
  (send recipe-name set-label (getRecipeAttribute 'name))
  (send display-picture set-label (read-bitmap (get-pure-port (string->url (getRecipeAttribute 'image)))))
  (send field-ingredients set-value (getRecipeAttribute 'ingredients))
  (send field-nutritional-facts set-value (getRecipeAttribute 'nutrition))
  (send field-url set-value (getRecipeAttribute 'url))
  (iterateCounter)
  (reset-yummly)
  (printf "Done\n"))
```

Racket GUI provides an easy way to change labels of an existing gui element. The code below looks for the 'field-url' object we already defined and changes the value to whatever we want. This is essentialy how we continously display new information each time the submit button is clicked.
```
(send field-url set-value (getRecipeAttribute 'url))
```

At first, displaying images from the web seemed tricky but it actually turned out quite simple. Net/url provided a simple procedure called 'get-pure-port' which basically retrieves whatever information is provided by the URL we create. The picture is then displayed using set-label.
```
(send display-picture set-label (read-bitmap (get-pure-port (string->url (getRecipeAttribute 'image)))))
```
