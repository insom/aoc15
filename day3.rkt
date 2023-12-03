#lang racket
(require rackunit)

(define (parse input)
  (let*
    ([grid (make-hash)]
     [inputs (string->list input)]
     [x 0] [y 0])
    (define (deliver x y)
      (hash-ref! grid (cons x y) (+ (hash-ref grid (cons x y) 0) 1)))
    (deliver 0 0)
    (for ([i inputs])
         (case i
           [(#\>) (set! x (+ x 1))]
           [(#\<) (set! x (- x 1))]
           [(#\v) (set! y (- y 1))]
           [(#\^) (set! y (+ y 1))])
         (deliver x y))
    (length (hash-keys grid))))

(check-equal? (parse "^>v<") 4)

(call-with-input-file "input3"
  (lambda (in)
     (let
       ([bits (string-split (port->string in) "\n" #:trim? #t)])
       (apply + (map parse bits)))))
