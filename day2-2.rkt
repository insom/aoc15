#lang racket
(require rackunit)

(define (parse input)
  (let*
    ([bits (string-split input "x")]
     [axes (sort (map string->number bits) <)])
    (+ (first axes) (first axes) (second axes) (second axes)
       (apply * axes))))

(check-equal? (parse "2x3x4") 34)

(call-with-input-file "input2"
  (lambda (in)
     (let
       ([bits (string-split (port->string in) "\n" #:trim? #t)])
       (apply + (map parse bits)))))
