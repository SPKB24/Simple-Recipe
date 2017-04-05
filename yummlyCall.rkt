#lang racket

(require net/url)
(require json)

(define yummlyUrl "http://api.yummly.com/v1/api/recipes?_app_id=ea7d9b93&_app_key=8df2515c1801eb355a8a879ce265df92&q=")

(define (add-ingredients ingredients)
  (if (null? ingredients)
      yummlyUrl
      (begin
        (if (null? (cdr ingredients))
            (set! yummlyUrl (string-append yummlyUrl (car ingredients)))
            (set! yummlyUrl (string-append yummlyUrl (car ingredients) "+")))
        (add-ingredients (cdr ingredients)))))

(define (getRecipes)
  (define in
    (get-pure-port
     (string->url yummlyUrl)))
  (define response-string (port->string in))
  (close-input-port in)
  (printf response-string))

(define (parseResponse responseString)
  (hash-ref (car (hash-ref (string->jsexpr responseString) 'resultSets)) 'rowSet))