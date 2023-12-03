#lang racket
(require rackunit)

(define (parse input)
  (let*
    ([grid (make-hash)]
     [inputs (string->list input)]
     [x-bot 0] [y-bot 0]
     [robot-turn #f]
     [x 0] [y 0])
    (define (deliver x y)
      (hash-ref! grid (cons x y) (+ (hash-ref grid (cons x y) 0) 1)))
    (deliver 0 0)
    (for ([i inputs])
         (if robot-turn
             (begin
               (case i
                   [(#\>) (set! x-bot (+ x-bot 1))]
                   [(#\<) (set! x-bot (- x-bot 1))]
                   [(#\v) (set! y-bot (- y-bot 1))]
                   [(#\^) (set! y-bot (+ y-bot 1))])
               (deliver x-bot y-bot))
             (begin
               (case i
                   [(#\>) (set! x (+ x 1))]
                   [(#\<) (set! x (- x 1))]
                   [(#\v) (set! y (- y 1))]
                   [(#\^) (set! y (+ y 1))])
               (deliver x y)))
         (set! robot-turn (not robot-turn)))
    (length (hash-keys grid))))

(check-equal? (parse "^>v<") 3)

(call-with-input-file "input3"
  (lambda (in)
     (let
       ([bits (string-split (port->string in) "\n" #:trim? #t)])
       (apply + (map parse bits)))))
