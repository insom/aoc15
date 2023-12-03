#lang racket
(require rackunit)

(define (parse input)
  (define ops (for/list ([i (string->list input)])
            (case i
              [(#\() 1]
              [(#\)) -1]
              [else 0])))
  (define (first-crossing operations floor step)
    (cond
        [(= floor -1) step]
        [else (first-crossing (rest operations) (+ floor (first operations)) (+ 1 step))]))
  (first-crossing ops 0 0))

(check-equal? (parse "()())") 5)

(call-with-input-file "input1"
  (lambda (in)
    (display (parse (port->string in)))))
