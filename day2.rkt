#lang racket
(require rackunit)

(define (parse input)
  (let*
    ([bits (string-split input "x")]
     [axes (map string->number bits)]
     [sides (sort (list
                (* (first axes) (second axes))
                (* (third axes) (second axes))
                (* (first axes) (third axes))) <)])
     (+ (first sides) (* 2 (apply + sides)))))

(check-equal? (parse "2x3x4") 58)

(call-with-input-file "input2"
  (lambda (in)
     (let
       ([bits (string-split (port->string in) "\n" #:trim? #t)])
       (apply + (map parse bits)))))
